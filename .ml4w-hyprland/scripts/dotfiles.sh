#!/usr/bin/env /usr/bin/bash

if [ ! -z "$user_dotfiles_dir"]; then
  echo ":: Using $user_dotfiles_dir."
  return
fi

user_dotfiles_dir="${USER_DOTFILES_DIR:-.local/share/repos/dotfiles}"

_define_dotfiles_folder() {
  echo ":: Specify dotfiles directory relative to home directory."
  echo
  user_dotfiles_dir_tmp=$(gum input --value "$user_dotfiles_dir" --placeholder "Enter the dotfiles directory")
  user_dotfiles_dir=${user_dotfiles_dir_tmp//[[:blank:]]/}
  if [ ! -z $user_dotfiles_dir ]; then
    _confirm_dotfiles_folder
  else
    echo "ERROR: Please define a folder name"
    _define_dotfiles_folder
  fi
}

_confirm_dotfiles_folder() {
  if [ -d ~/$user_dotfiles_dir ]; then
    echo ":: Using dotfiles directory ~/$user_dotfiles_dir."
    echo
    if gum confirm "Use this folder?"; then
      echo ":: ML4W dotfiles will be installed in ~/$user_dotfiles_dir."
    elif [ $? -eq 130 ]; then
      echo ":: Installation canceled."
      exit 130
    else
      _define_dotfiles_folder
    fi
  else
    echo "!! Dotfiles directory ~/$user_dotfiles_dir not found!"
    _define_dotfiles_folder
  fi
}

_confirm_dotfiles_folder
