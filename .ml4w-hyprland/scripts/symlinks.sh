#!/usr/bin/env /usr/bin/bash

symlinks=(

  ".config/Nextcloud"
  ".config/gdb"
  ".config/git"
  ".config/gnupg"
  ".config/hypr/conf/user"
  ".config/hypr/conf/user.conf"
  ".config/inputrc"
  ".config/lazygit"
  ".config/npm"
  ".config/nvim"
  ".config/zshrc/00-xdg-base-dirs"
  ".config/zshrc/01-exports"
  ".config/zshrc/05-aliases"
  ".config/zshrc/10-caps_esc_swap"
  ".config/zshrc/99-zsh-cache-override"
  ".local/bin/magnet-handler.sh"
  ".local/share/applications/magnet-handler.desktop"

)

echo ":: Removing existing links and files."
for item in "${symlinks[@]}"; do
  target="$HOME/$item"
  if [ -L "$target" ] || [ -f "$target" ]; then
    rm "$target"
  elif [ -d "$target" ]; then
    rm -rf "$target"
  fi
done

echo ":: Creating new symlinks."
for item in "${symlinks[@]}"; do
  target="$HOME/$item"
  source="$HOME/$user_dotfiles_dir/$item"
  if [ -e "$source" ]; then
    ln -sf "$source" "$target"
  else
    echo "ERROR: \"$source\" - No such file or directory."
    sleep 2
  fi
done
