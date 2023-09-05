#!/usr/bin/env zsh
[[ -x /usr/lib/xfce-polkit/xfce-polkit ]] && (pidof -s xfce-polkit || /usr/lib/xfce-polkit/xfce-polkit &)
