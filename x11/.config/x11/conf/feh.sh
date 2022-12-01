#!/usr/bin/sh
[[ -x /usr/bin/feh ]] && [[ -n $(ls -A $XDG_DATA_HOME/backgrounds 2> /dev/null) ]] && \
  feh --bg-fill --no-fehbg --randomize $XDG_DATA_HOME/backgrounds &
