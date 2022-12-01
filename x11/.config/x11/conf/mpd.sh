#!/usr/bin/sh
[[ -x /usr/bin/mpd ]] && (pidof -s mpd || mpd &)
