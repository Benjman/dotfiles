#!/bin/bash

sed "s/:.*$//" ~/.config/xrandr/profiles             | \
  sort                                               | \
  dmenu -i -p "Profile"                              | \
  xargs -I {} grep "^{}:" ~/.config/xrandr/profiles  | \
  sed "s/^.*: //"
