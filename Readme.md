Pogobot
=======

Table of contents
-----------------

- [Pogobot](#pogobot)
  - [Table of contents](#table-of-contents)
- [Overview](#overview)
- [Requirements](#requirements)
- [Install the dependencies](#install-the-dependencies)
  - [System dependency](#system-dependency)
  - [Litex](#litex)
  - [Cross Compiler](#cross-compiler)
  - [Adding your user to Dialout group](#adding-your-user-to-dialout-group)
- [pogoSDK](#pogosdk)
  - [Compile examples](#compile-examples)
  - [Compile and upload your own application](#compile-and-upload-your-own-application)
- [Install on Linux distributions other than Ubuntu by using Singularity Containers](#install-on-linux-distributions-other-than-ubuntu-by-using-singularity-containers)



Overview
========

We designed a robot with motors, SoC (system-on-chip) inside a
iCE40LP8K FPGA chip including a softcore processor, motors, sensors, LED, IR communication.
This SDK allows you to compile and upload code on the robot.

Please visit : https://github.com/nekonaute/pogobot-sdk or https://github.com/nekonaute/pogobot

Library refresh for the 2.7 firmware
------------------------------------

This SDK includes the library fixes from Pogobot's LTO/general-fixes change.
IR constructors reject oversized payloads before copying, transmitters wait
for FIFO space for every byte, and receivers validate lengths before processing
commands. Full 256-byte SPI security-register writes and signed timer
conversions are corrected. Receive-drop/malformed counters are available
through the updated headers.

Applications link their own copy of pogolib. Rebuild and re-upload an
application with this SDK to include the fixes; updating Pogobios alone does
not update that application code. The v2.7.1 raw flash-page signature and linker-capacity changes are described
below. The other existing application API signatures remain unchanged.

The prebuilt archive contains native fallback code as well as LTO information.
The ordinary example Makefiles work with the tested GCC 10.1.0 toolchain; LTO
is not a new requirement for application source. Compiler/source provenance
and the archive checksum are recorded in [SDK_BUILD.md](SDK_BUILD.md).
Hardware timing and behavior remain to be checked on robots.

Versioned IR upload tools
-------------------------

Use the existing `make connect TTY=/dev/ttyUSBX` command from an example,
then `run` and `rc_flash_robot` at the remote. The terminal recognizes the
updated remote automatically. Keep `tools/litex_term.py` and
`tools/ir_upload_v2.py` together; no Makefile flag is required.

Matching remote and robot firmware is required. Uploads use numbered 64-byte
chunks, an exact-image CRC and 16+4 erasure parity. Repeating `rc_flash_robot`
for the same image can reuse accepted chunks while receivers remain powered.
Progress reports acknowledgements by the remote, not completion on every
robot. Q cancels transmission. Direct cable uploads retain their protocol.

`POGOBOT_IR_COPIES=2 make connect TTY=/dev/ttyUSBX` requests another full pass.
The `firmware_integrity` example checks its installed image and can add an
adjustable flash-only payload for larger upload tests.

V3 flash and program limits
--------------------------

`read_page_flash` and `write_page_flash` now take `uint16_t` page IDs.
Rebuild applications and wrappers against the matched headers and archive.
Valid pages are 0..5887, each 256 bytes, at physical offsets
`0x90000..0x1FFFFF`. Public `POGOBOT_USER_FLASH_*` constants expose these bounds.
The flash example tests pages 0, 255, 256 and 5887 and erases the full region;
it destroys existing user data.

Generated linker/memory definitions allow 96 KiB programs. Code, data and
stack must still fit 128 KiB SRAM. This linker limit is separate from the
128 KiB physical firmware upload slot and the 1,472 KiB user-data region.
These capacities assume v3 hardware with 2 MiB flash.

PFFS files and saved controllers
-------------------------------

PFFS v4 file and append-log APIs are included in `libpogobot.a` and exposed
through `pogobot.h` or `pffs/flash_file.h` and `pffs/flash_log.h`.
The maintained core is distributed under `src/pffs` for native consumers;
hardware applications link the archive. See [the core API notes](src/pffs/README.md).

PFFS shares the raw flash region: 64 KiB is reserved for catalogs and
1,408 KiB for contiguous file extents. Raw page writes/erases can destroy
files. File operations require serialized access. Library creation retains
its documented autoformat policy for unformatted/corrupt catalogs; call
`pogo_flash_file_check()` first when preserving damaged data. Replacement and
compaction are not power-loss atomic.

The host tool `tools/pffs_transfer.py` uploads/downloads files over UART;
use `--help` for options. Firmware commands include explicit `format YES`,
file management, and verified `load <id|name>` installation of a raw
controller followed by `run`. `load_run <name>` and remote `rc_load_run` select
and start an exact named controller; failure shows red without starting an
older image. These commands require the matching BIOS.

`ir_send_file` on robots and `rc_send_file` on remotes broadcast named ordinary
files using parity and repeated passes. Receivers choose local IDs and verify
contents before publication. `--replace` preserves an existing ID and requires
matching format/page allocation; an interrupted replacement can destroy its
old contents. A pending reception locks file access until completion or local
`ir_file_abort`. There are no receiver acknowledgements or automatic relays.

Defragmentation remains in the library for maintenance applications such as
`pogo-utils/examples/flash_file`. It is omitted from the BIOS console. All PFFS
allocation/mutation must be coordinated with other flash users.

Requirements
============

The SDK works only on Ubuntu and is tested with Ubuntu 20.04.3 LTS and riscv64 gnu tools 8.3.0 and 10.1.0.


Install the dependencies
========================

Create dependencies directory

    mkdir -p dependencies

System dependency
-----------------

The list is adapted for Ubuntu distribution

    sudo apt-get -y install wget bison build-essential clang clang-format cmake flex gawk git graphviz libboost-all-dev libboost-dev libboost-filesystem-dev libboost-iostreams-dev libboost-program-options-dev libboost-python-dev libboost-system-dev libboost-thread-dev libeigen3-dev libffi-dev libftdi-dev libreadline-dev mercurial pkg-config python python3 python3-dev python3-pip python3-setuptools qt5-default tcl-dev xdot zlib1g-dev

    sudo pip3 install meson ninja
    echo "export PATH=\"\$PATH:~/.local/bin\"" >>~/.bashrc

Litex
-----

From https://github.com/enjoy-digital/litex

    mkdir -p dependencies/litex
    cd dependencies/litex
    wget https://raw.githubusercontent.com/enjoy-digital/litex/master/litex_setup.py
    chmod +x litex_setup.py
    ./litex_setup.py init

    cat ../../tools/litex_version.txt | awk '{ if(!system("test -d " $1)) {system("git -C " $1 " checkout " $3)}}'

    sudo ./litex_setup.py install


Cross Compiler
--------------

You need the cross-compiler gcc for the softcore.

    cd tools
    wget https://static.dev.sifive.com/dev-tools/freedom-tools/v2020.08/riscv64-unknown-elf-gcc-10.1.0-2020.08.2-x86_64-linux-ubuntu14.tar.gz
    tar xvf riscv64-unknown-elf-gcc-10.1.0-2020.08.2-x86_64-linux-ubuntu14.tar.gz

Adding compiler in the path

    export GCC_RISCV=$PWD/riscv64-unknown-elf-gcc-10.1.0-2020.08.2-x86_64-linux-ubuntu14/bin/
    echo "export PATH=\"\$PATH:$GCC_RISCV\"" >>~/.bashrc

Adding your user to Dialout group
---------------------------------

    sudo adduser $USER dialout

Reboot the PC.

pogoSDK
=======

Compile examples
----------------

The SDK comes with somes examples.
To compile and upload one. Please go to the example folder you want to test.

    make all
    make connect TTY=/dev/ttyUSB0

Inside the robot prompt, type "enter" to obtain a new prompt line.
After type the command "serialboot" to upload the code. 


Compile and upload your own application
---------------------------------------

To make a new application, duplicate an example. 
If you move to a new folder, don't forget to change the SDK path inside the Makefile.


Install on Linux distributions other than Ubuntu by using Singularity Containers
================================================================================

It is possible to build a [Singularity](https://docs.sylabs.io/guides/3.0/user-guide/index.html)/[Apptainer](https://apptainer.org/) image based on Ubuntu 20.04, which could then be used on any Linux distribution.
It may also be used to compile and install the sdk (including dependencies) if you have difficulties following the normal install procedure.

First, you need to install Singularity.
On Debian/Ubuntu distributions:
```bash
sudo apt update
sudo apt install -y wget lsb-release
export DISTRIB_NAME=$(lsb_release -c | cut -f 2)
wget https://github.com/sylabs/singularity/releases/download/v3.10.4/singularity-ce_3.10.4-${DISTRIB_NAME}_amd64.deb 
# Alternatively, download one of the .deb package available at https://github.com/sylabs/singularity/releases
sudo apt install -y ./singularity-ce_3.10.4-${DISTRIB_NAME}_amd64.deb
```
On other distributions, follow the procedure from [the official documentation](https://docs.sylabs.io/guides/3.0/user-guide/installation.html).

After that, you will need to either download an already compiled pogobot-sdk.sif image, or build it yourself.
To download an already compiled image:
```bash
cd pogobot-sdk
singularity pull --arch amd64 pogobot-sdk.sif library://leo.cazenille/pogobot/pogobot-sdk:latest
```
*Alternative*: to build it yourself (can take some time):
```bash
cd pogobot-sdk
sudo singularity build -F pogobot-sdk.sif pogobot-sdk.def
```
This will create a "pogobot-sdk.sif" image file (size: around 1.5GB).

To compile the helloworld example:
```bash
cd example/helloworld
singularity run --app make ../../pogobot-sdk.sif
```
or:
```bash
cd example/helloworld
singularity exec ../../pogobot-sdk.sif make clean all
```
