# Hide mouse when typing
[[ -x /usr/lib/xfce-polkit/xfce-polkit ]] && (pidof -s /usr/lib/xfce-polkit/xfce-polkit || /usr/lib/xfce-polkit/xfce-polkit &)
