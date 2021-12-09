#!/usr/bin/env bash
set -e

BRANCH=
REPO=https://github.com/neovim/neovim.git

[ -d /tmp/neovim ] && rm -r /tmp/neovim

mkdir -p /tmp/neovim

sudo apt install -y \
   autoconf \
   automake \
   cmake \
   make \
   curl \
   g++ \
   gettext \
   libtool \
   libtool-bin \
   ninja-build \
   pkg-config \
   python \
   python3 \
   python3-pip \
   unzip \
   clangd \
   llvm \
   ripgrep \
   fd-find

git clone $REPO /tmp/neovim

pushd .

cd /tmp/neovim
make CMAKE_BUILD_TYPE=Release
sudo make install

nvim --version


### install language servers
# jdtls
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

popd
