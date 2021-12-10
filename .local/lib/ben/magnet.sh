#!/usr/bin/env bash

# To get this to work in firefox:
#
# First register desktop file with ubuntu:
# desktop-file-install ~/.local/share/applications/magnet.desktop
#
# Then register the mime-type to the desktop file:
# gio mime x-scheme-handler/magnet magnet.desktop

/usr/bin/transmission-remote --auth transmission:transmission --add $1
