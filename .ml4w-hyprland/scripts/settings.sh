#!/usr/bin/bash

if [ -z "$(grep '^\(\s\+\)\?vi-mode' ~/.config/zshrc/20-customization)" ]; then
  sed -i "/^plugins=($/cplugins=(\n    vi-mode" ~/.config/zshrc/20-customization
  echo ":: Added vi-mode to zsh"
fi
sed -i "/HISTFILE=/cHISTFILE=~/.cache/zsh/history" ~/.config/zshrc/20-customization
echo ":: Changed zsh history file location"
