#!/usr/bin/env bash
set -e

BRANCH=""
[[ ! -z "$BRANCH" ]] && BRANCH="--branch ${BRANCH}"

sudo apt install -y \
   autoconf \
   automake \
   clangd \
   cmake \
   curl \
   fd-find \
   g++ \
   gettext \
   libtool \
   libtool-bin \
   llvm \
   make \
   ninja-build \
   nodejs \
   npm \
   pkg-config \
   python \
   python3 \
   python3-pip \
   ripgrep \
   ruby-dev \
   rustc \
   unzip

git clone git@github.com:Benjman/Neovim-from-scratch.git ~/.config/nvim

[ -d /tmp/neovim ] && rm -rf /tmp/neovim
git clone $BRANCH -- https://github.com/neovim/neovim.git /tmp/neovim

pushd . > /dev/null

cd /tmp/neovim
make CMAKE_BUILD_TYPE=Release
sudo make install

python3 -m pip install --user --upgrade pynvim
npm config set prefix '~/.local/share/npm'
npm install -g neovim \
  tree-sitter-cli

popd > /dev/null

nvim --version
