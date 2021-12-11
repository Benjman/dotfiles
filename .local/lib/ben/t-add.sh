#!/usr/bin/env bash

# This file checks if the transmission daemon is running, and if it is, it will add any
# queued torrents in ~/.cache/torrent-queue

[[ $# = 0 ]] && exit

if [ $(systemctl status transmission-daemon.service | grep '^\s\+Active: active' | wc -l) = 1 ]; then
    transmission-remote --auth transmission:transmission --add $@
else
    [[ $(grep "^$1\$" ~/.cache/torrent-queue | wc -l) = 0 ]] && \
        echo "$1" >> ~/.cache/torrent-queue
fi
