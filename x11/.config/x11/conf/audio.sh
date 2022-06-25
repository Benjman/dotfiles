#!/usr/bin/sh
[[ -x /usr/bin/pipewire ]] && (pidof  -s pipewire || pipewire & \
  pidof  -s pipewire-pulse || pipewire-pulse & \
  pidof  -s pipewire-media-session || pipewire-media-session &)
