# SDK build provenance

This SDK library refresh corresponds to Pogobot source commit
`7b6870ddc134fda51306f49e68f8fc7c804ab40f` (the LTO/general-fixes review branch).
The matching firmware source must be available in the source checkout before
rebuilding. The source revision is recorded independently of this generated
SDK repository's own commit.

| Build setting | Value |
|---|---|
| Platform | Pogobot v3 |
| CPU | VexRiscv Lite, rv32im / ilp32, 21 MHz |
| SRAM | 128 KiB |
| Program linker allowance | 64 KiB |
| Pogolib release identifier | v2.7 |
| Compiler | SiFive GCC 10.1.0-2020.08.2 |
| LiteX | `3ab7eaa5f7afb4d432b5641d7761813d3274d25f` |
| Library options | `-Os -flto -ffat-lto-objects -ffunction-sections -fdata-sections` |

The refreshed archive is `libs/libpogobot.a`. Its SHA-256 is:

```text
4e355509ce84338cd8978bdd2d7c2d3970d44ccb1e7ab4306dd73f03b5b851ea
```

`includes/version.h` records source/tool versions, and the generated `git.h`
records the matching source revision. The public headers and archive are copied
from the same generated SDK. The existing `libc.a` and `libcompiler_rt.a` are
retained; the example and API link checks use those exact distributed archives.
Unrelated generated timestamps and example edits are not part of this refresh.

From the pinned Pogobot source checkout, with its dependencies installed:

```sh
cd Software
./pogosoc.py --target=pogobotv3 --cpu-variant=lite --build
make -C sdk clean all TARGET=pogobotv3
```

The source Makefiles default to LTO. A clean build is needed when changing that
setting. The SDK is generated in `Software/sdk/build_sdk`. These commands include
a gateware build; an existing matching hardware build can be reused for a
software-only rebuild as described in the source repository.

The archive includes native code as well as LTO information. Linking with the
tested GCC 10.1.0 toolchain works with ordinary example Makefiles; an explicit
`-fno-lto` link also uses the native fallback. Other compiler versions have not
been revalidated for this refresh. Debug paths and generated build timestamps
can change archive bytes between builds, so the hash identifies the distributed
artifact rather than promising a path-independent reproducible binary.

No flash program, FPGA bitstream or installation script is supplied by this
SDK-only update.
