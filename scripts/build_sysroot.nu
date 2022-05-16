#!/usr/bin/env nu

cd build

mkdir sysroot/boot sysroot/bin sysroot/dev sysroot/run sysroot/etc/system sysroot/proc sysroot/sbin sysroot/newroot

# copy bootloader and kernel

echo "copying bootloader..."
cp kernel/arch/x86/boot/bzImage sysroot/boot
cp bootloader/*.bin sysroot/boot
cp bootloader/*.sys sysroot/boot
cp bootloader/*.EFI sysroot/boot
cp ../bootloader.cfg sysroot/boot/limine.cfg

# copy programs
echo "copying programs..."
strip -s ./shell/target/x86_64-unknown-linux-musl/debug/nu
cp ./shell/target/x86_64-unknown-linux-musl/debug/nu sysroot/bin
cp ./init sysroot/sbin
cp -r ../src/system/* sysroot/etc/system/

sudo mknod -m 0666 sysroot/dev/random c 1 8
sudo mknod -m 0666 sysroot/dev/urandom c 1 9
sudo chown root:root sysroot/dev/random sysroot/dev/urandom

echo "building the iso..."
(xorriso -as mkisofs -b boot/limine-cd.bin
        -no-emul-boot -boot-load-size 4 -boot-info-table
        --efi-boot boot/limine-cd-efi.bin
        -efi-boot-part --efi-boot-image --protective-msdos-label
        sysroot -o theos.iso)
./bootloader/limine-deploy ./theos.iso

truncate -s 5G rootfs.img
sudo mkfs.btrfs rootfs.img
sudo mkdir -p /mnt/rootfs
sudo mount -o loop rootfs.img /mnt/rootfs
sudo cp -r sysroot/* /mnt/rootfs/
sudo btrfs filesystem resize max /mnt/rootfs
sudo umount /mnt/rootfs

cd ../
echo "DONE"

