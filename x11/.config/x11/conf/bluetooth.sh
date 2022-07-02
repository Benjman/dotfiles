#!/usr/bin/sh

bluetoothctl << EOF
  select 08:BE:AC:2A:E6:BE
  power on
  connect 14:3F:A6:09:82:23
EOF

sleep 10 

pkill -RTMIN+$(awk '/SIGNAL_MEMORY/{print $7; exit}' ~/.local/lib/dwmblocks/config.h | tr -d ';') $(pidof dwmblocks)
