#!/usr/bin/sh

export BROWSER="/usr/bin/firefox"
export EDITOR="/usr/bin/nvim"
export TERMINAL="/usr/bin/alacritty"
export VISUAL="$EDITOR"

export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export GDBHISTFILE="$XDG_DATA_HOME/gdb/history"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export GOPATH="$XDG_DATA_HOME/go"
export GTK_THEME=Awaita:dark
export HISTCONTROL=ignoreboth
export HISTFILE="$XDG_CACHE_HOME/bash/history"
export LESSHISTFILE="-"
export MANPAGER='nvim -u ~/.config/nvim/custom/man.lua +Man!'
export MANWIDTH=999
export MAVEN_HOME=/opt/maven
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export PATH="$XDG_CONFIG_HOME/npm/bin:$PATH"

# removing the `.nv` directory from the home directory (see https://bbs.archlinux.org/viewtopic.php?id=166814):
export __GL_SHADER_DISK_CACHE_PATH="$XDG_DATA_HOME/nvidia"
