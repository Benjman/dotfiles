#!/usr/bin/bash

# ------------------------------------------------------
# Don't edit this section
# Include scripts.sh with helper functions
source ~/.ml4w-hyprland/library/scripts.sh
# ------------------------------------------------------

if [ -f ~/.ml4w-hyprland/post.sh ] && [ ! -h ~/.ml4w-hyprland/post.sh ]; then
  echo "ERROR: ~/.ml4w-hyprland/post.sh is not a symlink to the dotfiles directory"
  echo ":: Post cancelled"
  exit
fi

prev_dir="$(pwd)"
cd "$(dirname "$(realpath ~/.ml4w-hyprland/post.sh)")"

[[ -z $user_dotfiles_dir ]] && source scripts/dotfiles.sh

source scripts/packages.sh
_installPackagesAUR "${packagesAur[@]}"

source scripts/settings.sh
source scripts/symlinks.sh

cd $prev_dir
