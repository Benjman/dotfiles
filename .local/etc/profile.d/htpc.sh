alias htpcwake='wakeonlan -i $(grep "Host htpc" ~/.ssh/config -A 3 | grep "HostName" | head -n 1 | sed "s/\(\s\|HostName\)//g") 1c:69:7a:a2:6f:90'

