#!/usr/bin/sh
xrandr --output DP-0 --mode 2560x1440 --rate 120 --left-of DP-4 --output DP-4 --mode 2560x1440 --rate 144
dbus-update-activation-environment --systemd DISPLAY
