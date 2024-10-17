#!/usr/bin/env /usr/bin/bash

if [ -d ~/.config/ml4w/settings ]; then
  echo "top-right" >~/.config/ml4w/settings/dunst_position.sh
  echo ":: Set ml4w dunst position."

  echo "%a %Od.%Om.%Y" >~/.config/ml4w/settings/waybar_dateformat.sh
  echo ":: Set clock format."

  echo "1" >~/.config/ml4w/settings/waybar_workspaces.sh
  echo ":: Set workspace count."
fi
