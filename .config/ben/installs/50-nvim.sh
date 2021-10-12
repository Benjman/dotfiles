#!/usr/bin/env bash
set -e

DIR=$HOME/.local/lib/neovim
BRANCH=release-0.5
REPO=https://github.com/neovim/neovim.git
Z_PWD=$PWD

[ -d $DIR ] && echo "$DIR already exists. Aborting installation." && exit
mkdir -p $DIR
git clone --branch $BRANCH $REPO $DIR

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
	python-pip \
	python3 \
	python3-pip \
	unzip \
    clangd \
    llvm \
    ripgrep

cd $DIR
make CMAKE_BUILD_TYPE=Release
sudo make install

python3 -m pip install pynvim

nvim --version
