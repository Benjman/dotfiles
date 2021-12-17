#!/usr/bin/env bash
set -e

BRANCH=""

[[ ! -z "$BRANCH" ]] && BRANCH="--branch ${BRANCH}"

[ -d /tmp/neovim ] && rm -rf /tmp/neovim

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

git clone $BRANCH -- https://github.com/neovim/neovim.git /tmp/neovim

pushd . > /dev/null

cd /tmp/neovim
make CMAKE_BUILD_TYPE=Release
sudo make install

nvim --version

popd > /dev/null
