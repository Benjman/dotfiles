#!/bin/env /bin/bash

ls ~/.local/lib/scripts | \
  sed "s/\.sh//" | \
  dmenu -i -p "Script" | \
  xargs -I {} sh ~/.local/lib/scripts/{}.sh
