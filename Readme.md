Pogobot
=======

Table of contents
-----------------

- [Pogobot](#pogobot)
  - [Table of contents](#table-of-contents)
- [Overview](#overview)
- [Requirements](#requirements)
- [Install the dependencies](#install-the-dependencies)
- [pogoSDK](#pogosdk)
  - [Compile examples](#compile-examples)
  - [Compile and upload your own application](#compile-and-upload-your-own-application)



Overview
========

We designed a robot with motors, SoC (system-on-chip) inside a
iCE40LP8K FPGA chip including a softcore processor, motors, sensors, LED, IR communication.
This SDK allows you to compile and upload code on the robot.

Please visit : https://github.com/nekonaute/pogobot-sdk or https://github.com/nekonaute/pogobot

Requirements
============

The SDK works only on Ubuntu and is tested with Ubuntu 20.04.3 LTS and riscv64 gnu tools 8.3.0 and 10.1.0.


Install the dependencies
========================

You need the cross-compiler gcc for the softcore.

    cd tools
    wget https://static.dev.sifive.com/dev-tools/freedom-tools/v2020.08/riscv64-unknown-elf-gcc-10.1.0-2020.08.2-x86_64-linux-ubuntu14.tar.gz
    tar xvf riscv64-unknown-elf-gcc-10.1.0-2020.08.2-x86_64-linux-ubuntu14.tar.gz

Adding compiler in the path

    export GCC_RISCV=$PWD/riscv64-unknown-elf-gcc-10.1.0-2020.08.2-x86_64-linux-ubuntu14/bin/
    echo "export PATH=\"\$PATH:$GCC_RISCV\"" >>~/.bashrc


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

