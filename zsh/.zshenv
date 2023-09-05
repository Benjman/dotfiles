#!/bin/env /bin/bash

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

export EDITOR="/usr/bin/nvim"
export PAGER="/usr/bin/less"
export VISUAL="$EDITOR"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export PATH="$HOME/.local/bin${PATH:+:$PATH}"
