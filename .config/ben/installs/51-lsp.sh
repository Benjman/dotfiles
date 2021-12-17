#!/usr/bin/env bash
set -e
pushd . > /dev/null

#lua lsp
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


#jdtls
jdtls_ver=$(curl -s https://download.eclipse.org/jdtls/milestones/ | \
   grep -oP "\<div id='dirlist'\>.*</div>" | \
   sed 's/\<tr/\r\n/g' | \
   tail -n 2 | \
   head -n 1 | \
   grep -oh "href='.*'>" | \
   grep -o "'.*'" | \
   sed "s/'//g")

wget -O /tmp/jdtls.tar.gz https://download.eclipse.org$(curl -s https://download.eclipse.org$jdtls_ver/ | \
    grep -oP "edit-copy.*<a href='.*tar.gz'" | \
    grep -o "='.*" | \
    sed "s/[=']//g")

mkdir ~/.local/lib/jdtls
tar -xf /tmp/jdtls.tar.gz -C ~/.local/lib/jdtls


# cpp dap
sudo apt install build-essentials gdb -y


popd > /dev/null
