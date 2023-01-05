PACKAGES=libc libcompiler_rt libbase libfatfs liblitespi liblitedram libliteeth liblitesdcard liblitesata bios
PACKAGE_DIRS=/home/alexandre/pogobot-public/pogobot/dependencies/litex/litex/litex/soc/software/libc /home/alexandre/pogobot-public/pogobot/dependencies/litex/litex/litex/soc/software/libcompiler_rt /home/alexandre/pogobot-public/pogobot/dependencies/litex/litex/litex/soc/software/libbase /home/alexandre/pogobot-public/pogobot/dependencies/litex/litex/litex/soc/software/libfatfs /home/alexandre/pogobot-public/pogobot/dependencies/litex/litex/litex/soc/software/liblitespi /home/alexandre/pogobot-public/pogobot/dependencies/litex/litex/litex/soc/software/liblitedram /home/alexandre/pogobot-public/pogobot/dependencies/litex/litex/litex/soc/software/libliteeth /home/alexandre/pogobot-public/pogobot/dependencies/litex/litex/litex/soc/software/liblitesdcard /home/alexandre/pogobot-public/pogobot/dependencies/litex/litex/litex/soc/software/liblitesata /home/alexandre/pogobot-public/pogobot/dependencies/litex/litex/litex/soc/software/bios
LIBS=libc libcompiler_rt libbase libfatfs liblitespi liblitedram libliteeth liblitesdcard liblitesata
TRIPLE=riscv64-unknown-elf
CPU=vexriscv
CPUFAMILY=riscv
CPUFLAGS=-march=rv32im     -mabi=ilp32 -D__vexriscv__
CPUENDIANNESS=little
CLANG=0
CPU_DIRECTORY=/home/alexandre/pogobot-public/pogobot/dependencies/litex/litex/litex/soc/cores/cpu/vexriscv
SOC_DIRECTORY=/home/alexandre/pogobot-public/pogobot/dependencies/litex/litex/litex/soc
PICOLIBC_DIRECTORY=/home/alexandre/pogobot-public/pogobot/dependencies/litex/pythondata-software-picolibc/pythondata_software_picolibc/data
COMPILER_RT_DIRECTORY=/home/alexandre/pogobot-public/pogobot/dependencies/litex/pythondata-software-compiler_rt/pythondata_software_compiler_rt/data
export BUILDINC_DIRECTORY
BUILDINC_DIRECTORY=/home/alexandre/pogobot-public/pogobot/Software/build/pogobotv3/software/include
LIBC_DIRECTORY=/home/alexandre/pogobot-public/pogobot/dependencies/litex/litex/litex/soc/software/libc
LIBCOMPILER_RT_DIRECTORY=/home/alexandre/pogobot-public/pogobot/dependencies/litex/litex/litex/soc/software/libcompiler_rt
LIBBASE_DIRECTORY=/home/alexandre/pogobot-public/pogobot/dependencies/litex/litex/litex/soc/software/libbase
LIBFATFS_DIRECTORY=/home/alexandre/pogobot-public/pogobot/dependencies/litex/litex/litex/soc/software/libfatfs
LIBLITESPI_DIRECTORY=/home/alexandre/pogobot-public/pogobot/dependencies/litex/litex/litex/soc/software/liblitespi
LIBLITEDRAM_DIRECTORY=/home/alexandre/pogobot-public/pogobot/dependencies/litex/litex/litex/soc/software/liblitedram
LIBLITEETH_DIRECTORY=/home/alexandre/pogobot-public/pogobot/dependencies/litex/litex/litex/soc/software/libliteeth
LIBLITESDCARD_DIRECTORY=/home/alexandre/pogobot-public/pogobot/dependencies/litex/litex/litex/soc/software/liblitesdcard
LIBLITESATA_DIRECTORY=/home/alexandre/pogobot-public/pogobot/dependencies/litex/litex/litex/soc/software/liblitesata
BIOS_DIRECTORY=/home/alexandre/pogobot-public/pogobot/dependencies/litex/litex/litex/soc/software/bios
SPIFLASH_BASE=0x200000
ROM_BASE=0x260000
