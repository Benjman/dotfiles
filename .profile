if [ -d $HOME/.local/etc/profile.d ]; then
  for i in $HOME/.local/etc/profile.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi

[[ -d $HOME/.config/personal && -f $HOME/.config/personal/.profile ]] && . $HOME/.config/personal/.profile
