#!/bin/sh

# xinitrc runs automatically when you run startx.

# There are some small but important commands that need to be run when we start
# the graphical environment. There is a link to this file in ~/.xprofile
# because that file is run automatically if someone uses a display manager
# (login screen) and so they are needed there. To prevent doubling up commands,
# I source them here with the line below.

echo "Hit 0" >> /tmp/xinitrc
if [ -f ~/.config/x/xprofile ]; then
  echo "Hit 1" >> /tmp/xinitrc
	source "${XDG_CONFIG_HOME:-$HOME/.config}/x/xprofile"
else
  echo "Hit 2" >> /tmp/xinitrc
	source "$HOME/.xprofile"
fi

ssh-agent dwm
