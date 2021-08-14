#!/usr/bin/env bash
set e

DIR=$HOME/.local/lib/neovim
BRANCH=release-0.5
REPO=https://github.com/neovim/neovim.git
Z_PWD=$PWD

[ -d $DIR ] && echo "$DIR already exists. Aborting installation." && exit
mkdir -p $DIR
git clone --branch $BRANCH $REPO $DIR

sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl

cd $DIR
make CMAKE_BUILD_TYPE=Release
sudo make install

[ -e python3 ] && python3 -m pip install pynvim

nvim --version
