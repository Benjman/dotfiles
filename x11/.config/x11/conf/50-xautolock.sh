#!/usr/bin/env zsh
[[ -x /usr/bin/xautolock ]] && [[ -x /usr/bin/slock ]] && \
  (pidof -s xautolock || xautolock -corners +00- -time 15 -locker slock &)
