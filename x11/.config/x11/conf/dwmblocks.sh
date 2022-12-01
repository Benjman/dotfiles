#!/usr/bin/sh
# Status bar (If this is crashing dwm, that means color emojis havne't been enabled: Install `yay -S libxft-bgra`!!!)
[[ -x ~/.local/bin/dwmblocks ]] && (pidof -s dwmblocks || dwmblocks &)
