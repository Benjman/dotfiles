if [[ "$(tty)" = "/dev/tty1" ]]; then
  pgrep ~/.local/bin/dwm || startx $XDG_CONFIG_HOME/x11/xinitrc
fi
