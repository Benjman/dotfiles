#!/usr/bin/env /usr/bin/bash

if [ -f ~/.config/zshrc/20-customization ]; then
  if [ -z "$(grep '^\(\s\+\)\?vi-mode' ~/.config/zshrc/20-customization)" ]; then
    sed -i "/^plugins=($/cplugins=(\n    vi-mode" ~/.config/zshrc/20-customization
    echo ":: Added vi-mode to zsh."
  fi

  sed -i "/HISTFILE=/cHISTFILE=~/.cache/zsh/history" ~/.config/zshrc/20-customization
  echo ":: Changed zsh history file location."
fi

if [[ -n "$GNUPGHOME" && -d "$GNUPGHOME" ]]; then
  chmod 700 "$GNUPGHOME"
  echo ":: Updated \$GNUPGHOME permissions."
fi

if [ -d ~/.local/share/applications ]; then
  update-desktop-database ~/.local/share/applications
  echo ":: Updated desktop database."
fi

if [ $(grep "^source = ~/.config/hypr/conf/user.conf" ~/.config/hypr/conf/custom.conf | wc -l) -eq 0 ]; then
  echo "" >>~/.config/hypr/conf/custom.conf # intentional blank line
  echo "source = ~/.config/hypr/conf/user.conf" >>~/.config/hypr/conf/custom.conf
  echo ":: Added user configuration sourcing to hyprland."
fi
