#!/usr/bin/env bash

[[ $# -eq 0 ]] && exit

# try to add to htpc first
HTPC_URL=$(grep 'htpc' ~/.ssh/config -A3 | grep -o '\([0-9]\+\.\)\+[0-9]\{0,3\}' | head -n1)
ping -c1 $HTPC_URL > /dev/null
if [ $? -eq 0 ] && \
  [ $(ssh htpc systemctl status transmission-daemon.service | grep '^\W\+Active: active' | wc -l) -eq 1 ]; then
  transmission-remote $HTPC_URL:9091 --add --auth transmission:transmission $@
  exit
fi
unset HTPC_URL
