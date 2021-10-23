#!/usr/bin/env bash
set -e

#sudo apt install -y \
#    autoconf \
#    automake \
#    cmake \
#    make \
#    curl \
#    g++ \
#    gettext \
#    libtool \
#    libtool-bin \
#    ninja-build \
#    pkg-config \
#    python \
#    python3 \
#    python3-pip \
#    unzip \
#    clangd \
#    llvm \
#    ripgrep \
#    fd-find

[ -d /tmp/neovim ] && rm -r /tmp/neovim

DIR=/tmp/neovim
BRANCH=v0.5.1
REPO=https://github.com/neovim/neovim.git
Z_PWD=$PWD

mkdir -p $DIR
git clone --branch $BRANCH $REPO $DIR

cd $DIR
make CMAKE_BUILD_TYPE=Release
sudo make install

nvim --version

cd $Z_PWD
