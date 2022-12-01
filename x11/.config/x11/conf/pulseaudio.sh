#!/usr/bin/sh
# Helps with puls audio
[[ -x /usr/bin/pasystray ]] && (pidof -s pasystray || pasystray &)
