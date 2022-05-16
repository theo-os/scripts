#!/usr/bin/env nu

qemu-system-x86_64 -cdrom build/theos.iso -m 1024 -serial stdio -hda build/rootfs.img

