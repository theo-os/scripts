#!/usr/bin/env nu

(git clone
	https://github.com/zen-kernel/zen-kernel
	--depth 1
	build/kernel)

cd build/kernel
make olddefconfig
make -j"$(nproc)"
cd ../../
