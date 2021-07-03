# enable vi mode in shell script
set -o vi

export BROWSER=/usr/bin/firefox
export EDITOR=/usr/bin/vim
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export HISTCONTROL=ignoreboth
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_QPA_PLATFORMTHEME="stilt"
export VISUAL=$EDITOR

export PATH="$HOME/.local/bin:$PATH"
