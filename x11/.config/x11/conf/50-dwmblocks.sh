#!/usr/bin/sh
[[ -x "$HOME/.local/bin/dwmblocks" ]] && (pidof -s dwmblocks || dwmblocks & )
