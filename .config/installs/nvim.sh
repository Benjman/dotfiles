#!/usr/bin/env bash
set -e

[ ! -d ~/.local/bin ] && mkdir -p ~/.local/bin

BRANCH=''
[[ ! -z '$BRANCH' ]] && BRANCH='--branch ${BRANCH}'

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

NVIM_CONFIG_URL='Benjman/Neovim-from-scratch.git'
git clone git@github.com:$NVIM_CONFIG_URL ~/.config/nvim 2> /dev/null || \
  git clone https://github.com/$NVIM_CONFIG_URL ~/.config/nvim
unset NVIM_CONFIG_URL

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

# install lazygit
LAZYGIT_URL=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases | \
  grep -m1 -o 'https://github.com/jesseduffield/lazygit/releases/download/v\(\([0-9\.]\)\+\)/lazygit_\1_Linux_32-bit\.tar\.gz')
wget -c $LAZYGIT_URL -O - | tar -xz -C ~/.local/bin lazygit
unset LAZYGIT_URL

popd > /dev/null

nvim --version
