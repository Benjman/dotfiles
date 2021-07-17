LEN=32
MAX_LEN=48

# check dependencies
[[ "$(apt list --installed xclip 2> /dev/null | wc -l)" -lt 2 ]] && \
	echo -e "Missing dependencies. Run the following: \`sudo apt install xclip\`" && exit

# Check for override to default length
[[ $# -gt 0 ]] && LEN="$1"

# Clamp length
[[ $LEN -gt $MAX_LEN ]] && LEN=$MAX_LEN && >&2 echo "ERROR: Max password length is $MAX_LEN" && exit

# Generate password
PASS=$(openssl rand -base64 $MAX_LEN | cut -c1-$LEN)

# Place password into clipboard
echo $PASS | xclip -sel clip


echo -e "$PASS\nSaved password to your clipboard."
