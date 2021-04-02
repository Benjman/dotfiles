#!/bin/sh

[ $# -eq 0 ] && echo "Missing torrent number." && exit

transmission-remote -t $1 -r

