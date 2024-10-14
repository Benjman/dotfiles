#!/usr/bin/bash

echo ":: Creating symlinks"

symlinks=(

  ".config/Nextcloud"
  ".config/gdb"
  ".config/git"
  ".config/gnupg"
  ".config/hypr/conf/user"
  ".config/inputrc"
  ".config/lazygit"
  ".config/npm"
  ".config/nvim"
  ".config/zshrc/00-user-xdg-base-dirs"
  ".config/zshrc/01-user-exports"
  ".config/zshrc/01-user-path-extensions"
  ".config/zshrc/05-user-aliases"
  ".config/zshrc/99-user-caps_esc_swap"
  ".config/zshrc/99-user-zsh-cache-override"

)

# Remove existing links and files
for item in "${symlinks[@]}"; do
  target="$HOME/$item"
  if [ -L "$target" ] || [ -f "$target" ]; then
    rm "$target"
    echo ":: Removed existing file/link $target"
  elif [ -d "$target" ]; then
    rm -rf "$target"
    echo ":: Removed existing directory $target"
  fi
done

# Create new symlinks
for item in "${symlinks[@]}"; do
  target="$HOME/$item"
  source="$HOME/$user_dotfiles_dir/$item"
  if [ ! -e "$source" ]; then
    echo "!! Failed to locate file or directory $source"
    sleep 2
    continue
  fi
  ln -sf "$source" "$target"
  echo ":: Created symlink for $target"
done

[[ -d ~/.config/hypr/conf/user ]] && rm ~/.config/hypr/conf/user
ln -s $HOME/$user_dotfiles_dir/.config/hypr/conf/user ~/.config/hypr/conf

if [ $(grep "^source = ~/.config/hypr/conf/user/user.conf" ~/.config/hypr/conf/custom.conf | wc -l) -eq 0 ]; then
  echo "" >>~/.config/hypr/conf/custom.conf # Intentional blank line
  echo "source = ~/.config/hypr/conf/user/user.conf" >>~/.config/hypr/conf/custom.conf
  echo ":: Added user sourcing to hypr conf"
fi
