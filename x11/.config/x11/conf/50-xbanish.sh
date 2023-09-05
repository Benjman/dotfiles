#!/usr/bin/env zsh
[[ -x /usr/bin/xbanish ]] && (pidof -s xbanish || xbanish &)
