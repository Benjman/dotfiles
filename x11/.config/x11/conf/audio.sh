#!/usr/bin/sh
[[ -x /usr/bin/pipewire ]] && ( \
  pidof -s pipewire || pipewire & \
  pidof -s pipewire-pulse || pipewire-pulse & \
  pidof -s pipewire-media-session || (pipewire-media-session && sleep 2 && pkill -RTMIN+$(awk '/sb-volume/{print $4}' ~/.local/lib/dwmblocks/config.h | tr -d '},') dwmblocks) & \
)
