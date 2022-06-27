# Screen lock after `-time n` minutes
[[ -x /usr/bin/xautolock && -x /usr/local/bin/slock ]] && (pidof -s xautolock || xautolock -time 15 -locker slock &)
