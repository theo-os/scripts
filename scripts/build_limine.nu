#!/usr/bin/env nu

(git clone
	https://github.com/limine-bootloader/limine
	--depth 1
	--branch v3.0-branch-binary
	build/bootloader)

cd build/bootloader
make limine-deploy
cd ../../
