if [[ "$(tty)" = "/dev/tty1" ]]; then
  pgrep dwm || startx $XDG_CONFIG_HOME/x11/xinitrc
fi
