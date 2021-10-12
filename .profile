# enable vi mode in shell script
set -o vi

if [ -d $HOME/.config/profile.d ]; then
  for i in $HOME/.config/profile.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi

