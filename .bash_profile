#
# ~/.bash_profile
#
# enable vi mode
[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

set -o vi

export VISUAL=vim
export EDITOR="$VISUAL"
export HISTCONTROL=ignoreboth
