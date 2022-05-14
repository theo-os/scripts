#!/usr/bin/env nu

(git clone --depth 1
	https://github.com/nushell/nushell
	build/shell)

cd build/shell
cargo build --target=x86_64-unknown-linux-musl --features=static-link-openssl
cd ../../
