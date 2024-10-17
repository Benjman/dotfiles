#!/usr/bin/env /usr/bin/bash

if [ -f ~/.ml4w-hyprland/library/scripts.sh ]; then
  # ------------------------------------------------------
  # Don't edit this section
  # Include scripts.sh with helper functions
  source ~/.ml4w-hyprland/library/scripts.sh
  # ------------------------------------------------------

  if [ ! -h ~/.ml4w-hyprland/post.sh ]; then
    echo "ERROR: ~/.ml4w-hyprland/post.sh is not a symlink to the dotfiles directory"
    # FIXME: Prompt for location of post script, and create the symlink
    echo ":: post cancelled."
    exit
  fi

  prev_dir="$(pwd)"
  cd "$(dirname "$(realpath ~/.ml4w-hyprland/post.sh)")"

  [[ -z $user_dotfiles_dir ]] && source scripts/dotfiles.sh

  source scripts/packages.sh
  _installPackagesAUR "${packagesAur[@]}"

  source scripts/settings.sh
  source scripts/symlinks.sh
  source scripts/cleanup.sh

  cd $prev_dir
fi
