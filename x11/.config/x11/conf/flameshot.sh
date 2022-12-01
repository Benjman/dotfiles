#!/usr/bin/sh
# Screenshots
[[ -x /usr/bin/flameshot ]] && (pidof -s flameshot || flameshot &)
