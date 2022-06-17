#!/bin/bash

$(sed "s/:.*$//" ~/.config/xrandr/profiles           | \
  dmenu -i -p "Profile"                              | \
  xargs -I {} grep "^{}:" ~/.config/xrandr/profiles  | \
  sed "s/^.*: //")
