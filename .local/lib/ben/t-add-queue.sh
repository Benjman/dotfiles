#!/usr/bin/env bash

# This file checks if the transmission daemon is running, and if it is, it will add any
# queued torrents in ~/.cache/torrent-queue

[[ $(systemctl status transmission-daemon.service | grep '^\s\+Active: active' | wc -l) = 0 ]] && exit
[[ ! -f ~/.cache/torrent-queue ]] && exit

while read torrent; do
    t-add "$torrent"
done < ~/.cache/torrent-queue

rm ~/.cache/torrent-queue
