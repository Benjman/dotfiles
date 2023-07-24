#!/usr/bin/env bash

[[ -z "$1" ]] && url="$(xclip -o)" || url="$1"

case "$url" in
  *mkv|*webm|*mp4|*youtube.com/watch*|*youtube.com/playlist*|*youtube.com/shorts*|*youtu.be*)
    setsid -f mpv --ytdl-format=22 -quiet "$url" >/dev/null 2>&1 ;;
  *png|*jpg|*jpe|*jpeg|*gif)
    curl -sL "$url" > "/tmp/$(echo "$url" | sed "s/.*\///;s/%20/ /g")" && sxiv -a "/tmp/$(echo "$url" | sed "s/.*\///;s/%20/ /g")"  >/dev/null 2>&1 & ;;

  *)
    [ -f "$url" ] && setsid -f "$TERMINAL" -e "$EDITOR" "$url" >/dev/null 2>&1 || setsid -f "$BROWSER" "$url" >/dev/null 2>&1
esac
