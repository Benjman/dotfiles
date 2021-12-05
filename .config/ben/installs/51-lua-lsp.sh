#!/usr/bin/env bash
set -e
pushd . > /dev/null

sudo apt install ninja-build -y

cd ~/.local/lib
git clone https://github.com/sumneko/lua-language-server
cd lua-language-server
git submodule update --init --recursive
cd 3rd/luamake
./compile/install.sh
cd ../..
./3rd/luamake/luamake rebuild
cd ~/.local/bin
ln -s ~/.local/lib/lua-language-server/bin/Linux/lua-language-server .

popd > /dev/null
