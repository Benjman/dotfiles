#!/usr/bin/env zsh
xset s off # Don't randomly turn off
xset -dpms
xset s noblank
xset b off # Disable beep
xset r rate 195 40 # Speedy keys
setxkbmap -option caps:swapescape
xmodmap "$XDG_DATA_HOME/xorg/.Xmodmap"
