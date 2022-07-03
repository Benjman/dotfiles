#!/usr/bin/sh
[[ -x /usr/bin/picom ]] && (pidof -s picom || picom &)
