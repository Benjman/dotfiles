#!/usr/bin/env /usr/bin/bash

_transmission_PromptStart() {
  # TODO: Cache response for some period of time?
  if zenity \
    --question \
    --no-wrap \
    --icon=transmission \
    --title="Start Transmission" \
    --text="Do you want to start the transmission daemon now?\n\n(Selecting \"No\" will queue the magnet)"; then
    systemctl start transmission.service
  fi
}

_transmission_QueueMagnet() {
  # TODO: Add the file to the directory transmission-daemon looks in for magnets/torrents
}

_transmission_AddMagnet() {
  if ! transmission-remote --add "$@"; then
    notify-send -i dialog-error -a transmission-daemon "Failed to add magnet!"
    sleep 2
    exit 1
  else
    notify-send -i dialog-positive -a transmission-daemon "Added magnet"
    exit 0
  fi
}

if [ "active" = "$(systemctl is-active transmission.service)" ]; then
  _transmission_AddMagnet "$@"
else
  _transmission_PromptStart
  if [ $? -eq 0 ]; then
    _transmission_AddMagnet "$@"
  else
    _transmission_QueueMagnet
  fi
fi
