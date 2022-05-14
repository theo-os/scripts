# ParisOS Build Scripts

This repository contains the scripts required to build a minimal ISO of ParisOS.

## Requirements

- a linux machine
- [rustup/rust nightly](https://rustup.rs)
- xorriso
- mkisofs
- [nushell](https://www.nushell.sh/book)
- root access with sudo
- a C toolchain (such as clang), along with make and bc

## Building an Disk Image

```nushell
./scripts/build_kernel.nu
./scripts/build_shell.nu
./scripts/build_limine.nu
./scripts/build_iso.nu
```

The last command will prompt you for a sudo password, which is only required to create the device nodes for linux to function.

## Running With QEMU

```nushell
qemu-system-x86_64 -hda build/theos.iso -m 1024 -serial stdio
```

