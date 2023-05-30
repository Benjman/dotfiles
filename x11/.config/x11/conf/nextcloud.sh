#!/usr/bin/sh
# Cloud storage
[[ -x /usr/bin/nextcloud ]] && (pidof -s nextcloud || nextcloud --background & )
