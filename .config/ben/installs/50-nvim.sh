#!/usr/bin/env bash
set -e

BRANCH=''
[[ ! -z '$BRANCH' ]] && BRANCH='--branch ${BRANCH}'

NVIM_CONFIG_URL='Benjman/Neovim-from-scratch.git'

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

git clone git@github.com:$NVIM_CONFIG_URL ~/.config/nvim 2> /dev/null || \
  git clone https://github.com/$NVIM_CONFIG_URL ~/.config/nvim

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
curl -s https://api.github.com/repos/jesseduffield/lazygit/releases | \
  grep 'https://.*lazygit_.*Linux_32.*\.tar\.gz' | \
  cut -d : -f 2,3 |  \
  tr -d \" |  \
  head -n 1 |  \
  wget -O ~/.local/bin/lazygit.tar.gz -qi - && \
  tar -xf ~/.local/bin/lazygit.tar.gz -C ~/.local/bin/ && \
  rm ~/.local/bin/lazygit.tar.gz

popd > /dev/null

nvim --version
