# Hide mouse when typing
[[ -x /usr/bin/xbanish ]] && (pidof -s xbanish || xbanish &)
