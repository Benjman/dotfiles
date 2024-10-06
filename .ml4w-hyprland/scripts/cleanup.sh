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

if [ -d ~/.npm ]; then
  if [ -n "$NPM_CONFIG_USERCONFIG" ]; then
    npm_dir=$(eval "echo $(grep prefix $NPM_CONFIG_USERCONFIG | awk -F"=" '{print $2}')")
    if [ -n "$npm_dir" ]; then
      mv ~/.npm $npm_dir
    else
      echo "ERROR: Failed to move ~/npm: Could not find prefix directory"
      sleep 2
    fi
  else
    echo "ERROR: Failed to move ~/.npm: \$NPM_CONFIG_USERCONFIG not set"
    sleep 2
  fi
fi
