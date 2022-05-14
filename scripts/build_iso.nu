#!/usr/bin/env nu

cd build

mkdir iso/boot iso/bin iso/dev iso/run
mkdir iso/root/.config/nushell

# copy bootloader and kernel

echo "copying bootloader..."
cp kernel/arch/x86_64/boot/bzImage iso/boot
cp bootloader/*.bin iso/boot
cp bootloader/*.sys iso/boot
cp bootloader/*.EFI iso/boot
cp ../bootloader.cfg iso/boot/limine.cfg

# copy programs
echo "copying programs..."
strip -s ./shell/target/x86_64-unknown-linux-musl/debug/nu
cp ./shell/target/x86_64-unknown-linux-musl/debug/nu iso/bin

sudo bin/mknod -m 0666 iso/dev/random c 1 8
sudo mknod -m 0666 iso/dev/urandom c 1 9
sudo chown root:root iso/dev/random iso/dev/urandom

# build the iso
echo "building the iso..."
(xorriso -as mkisofs -b boot/limine-cd.bin
        -no-emul-boot -boot-load-size 4 -boot-info-table
        --efi-boot boot/limine-cd-efi.bin
        -efi-boot-part --efi-boot-image --protective-msdos-label
        iso -o theos.iso)
./bootloader/limine-deploy ./theos.iso 

cd ../

echo "DONE"

