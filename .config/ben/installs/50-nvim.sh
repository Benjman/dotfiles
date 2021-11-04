#!/usr/bin/env bash
set -e

BRANCH=v0.5.1
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

git clone --branch $BRANCH $REPO /tmp/neovim

pushd .

cd /tmp/neovim
make CMAKE_BUILD_TYPE=Release
sudo make install

nvim --version

popd
