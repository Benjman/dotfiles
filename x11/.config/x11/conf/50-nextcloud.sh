#!/usr/bin/env zsh
[[ -x /usr/bin/nextcloud ]] && (pidof -s nextcloud || nextcloud --background & )
