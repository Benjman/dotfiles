# enable vi mode in shell script
set -o vi

export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export HISTCONTROL=ignoreboth
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_QPA_PLATFORMTHEME="stilt"
export VISUAL=$EDITOR

if [ -d $HOME/.config/profile.d ]; then
  for i in $HOME/.config/profile.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi

