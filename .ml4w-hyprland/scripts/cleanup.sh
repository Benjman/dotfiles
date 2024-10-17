#!/usr/bin/env /usr/bin/bash

[[ -f ~/.wget-hsts ]] && rm ~/.wget-hsts

if [ -d ~/go ]; then
  if [ -n "$GOPATH" ]; then
    mv ~/go $GOPATH
  else
    echo "ERROR: Failed to move ~/go: \$GOPATH not set"
    sleep 2
  fi
fi
