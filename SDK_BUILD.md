# SDK build provenance

The library, public headers and memory configuration correspond to Pogobot
source commit `a56cf56ca31e01fc8cca12d1f3d26616d6da2f68`. The matching source must be available in the checkout
before rebuilding. This is the firmware source revision, independent of this
generated SDK repository's own commit.

| Build setting | Value |
|---|---|
| Platform | Pogobot v3, 2 MiB flash |
| CPU | VexRiscv Lite, rv32im / ilp32, 21 MHz |
| SRAM | 128 KiB |
| Program linker allowance | 96 KiB |
| Raw user-data region | 5,888 pages of 256 bytes, 1,472 KiB |
| Pogolib release identifier | v2.7 |
| Compiler | SiFive GCC 10.1.0-2020.08.2 |
| LiteX | `3ab7eaa5f7afb4d432b5641d7761813d3274d25f` |
| Library options | `-Os -flto -ffat-lto-objects -ffunction-sections -fdata-sections` |

The refreshed archive is `libs/libpogobot.a`. Its SHA-256 is:

```text
a7c8df6ab4111394e94519121cd7fafc896bd2d687a12b68af48195b562879f5
```

`includes/version.h` records source/tool versions; the generated `git.h` records
the matching source revision. Public headers and the archive come from the same
generated SDK, with two trailing spaces in imported comments omitted. Existing
`libc.a`, `libcompiler_rt.a` and hardware headers whose only changes were build
timestamps are retained. Validation uses those exact distributed runtime
archives rather than silently substituting a full generated SDK.

The versioned IR uploader first appears in Pogobot commit
`382b09e8204ea1e9c3e30566292224d5bc4ac551`. Its two modules are packaged together.

From the pinned Pogobot source checkout, with its dependencies installed:

```sh
cd Software
./pogosoc.py --target=pogobotv3 --cpu-variant=lite --build
make -C sdk clean all TARGET=pogobotv3
```

Source Makefiles default to LTO. A clean build is needed when changing that
setting. The generated SDK is `Software/sdk/build_sdk`. The commands include a
gateware build; an existing matching hardware build can be reused for a
software-only rebuild as described in the source repository.

The archive contains native fallback code as well as LTO information. Standard
example Makefiles and explicit `-fno-lto` links are tested with GCC 10.1.0.
Other compiler versions have not been revalidated for this refresh. Debug paths
and generated timestamps can change archive bytes, so the checksum identifies
this artifact rather than promising a path-independent reproducible binary.

A 96 KiB linker allowance is not a 96 KiB free-SRAM guarantee. Actual code,
initialized/static data and stack must fit the robot's 128 KiB SRAM. The raw
user-flash region is storage, not additional RAM.

No FPGA bitstream, flashable BIOS or installation script is included here.
Install a matching firmware release separately. Actual peripheral timing,
persistence and boot behavior still require hardware validation.
