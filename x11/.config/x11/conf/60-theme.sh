#!/usr/bin/env zsh

[[ -d ~/.local/share/nextcloud/backgrounds ]] && feh -Z --bg-fill --no-fehbg --randomize ~/.local/share/nextcloud/backgrounds &

xrdb "$XDG_DATA_HOME/xorg/xresources" & xrdbpid=$!
# Ensure that xrdb has finished running before moving on to start the WM/DE.
[ -n "$xrdbpid" ] && wait "$xrdbpid"
