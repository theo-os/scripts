#!/usr/bin/env nu

(git clone
	https://github.com/zen-kernel/zen-kernel
	--depth 1
	build/kernel)

cd build/kernel
cp ../../kernel-config.cfg ./.config
make olddefconfig
make -j 4 
cd ../../
