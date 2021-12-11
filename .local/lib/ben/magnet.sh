#!/usr/bin/env bash

# Setup:
#   You may need to register the desktop file with Ubuntu:
#     $ desktop-file-install ~/.local/share/applications/magnet.desktop
#
#   Then, register our desktop file with the magnet mime-type:
#     $ gio mime x-scheme-handler/magnet magnet.desktop
#
#
# This script will check if the daemon is running. If it is, it will add it
# to the daemon. If it is not, it will add it to a queue to be added the next
# time `t-add` is ran.

if [ $(systemctl status transmission-daemon.service | grep '^\s\+Active: active' | wc -l) = 1 ]; then
    /usr/bin/transmission-remote --auth transmission:transmission --add $1
else
    [[ $(grep "^$1\$" ~/.cache/torrent-queue | wc -l) = 0 ]] && \
        echo "$1" >> ~/.cache/torrent-queue
fi

