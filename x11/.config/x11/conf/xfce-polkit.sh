#!/usr/bin/env bash
[[ -x /usr/lib/xfce-polkit/xfce-polkit ]] && (pidof -s xfce-polkit || /usr/lib/xfce-polkit/xfce-polkit &)
