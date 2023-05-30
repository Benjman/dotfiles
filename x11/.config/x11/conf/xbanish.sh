#!/usr/bin/sh
# Automatically hide the mouse cursor when typing.
[[ -x /usr/bin/xbanish ]] && (pidof -s xbanish || xbanish &)
