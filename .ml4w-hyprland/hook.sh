#!/usr/bin/bash

# ------------------------------------------------------
# Don't edit this section
# Include scripts.sh with helper functions
source ~/.ml4w-hyprland/library/scripts.sh
# ------------------------------------------------------

if [ -f ~/.ml4w-hyprland/hook.sh ] && [ ! -h ~/.ml4w-hyprland/hook.sh ]; then
  echo "ERROR: ~/.ml4w-hyprland/hook.sh is not a symlink to the dotfiles directory"
  echo ":: Hook cancelled"
  exit
fi

prev_dir="$(pwd)"
cd "$(dirname "$(realpath ~/.ml4w-hyprland/hook.sh)")"

[[ -z $user_dotfiles_dir ]] && source scripts/dotfiles.sh

source scripts/ml4w-settings.sh

cd $prev_dir
