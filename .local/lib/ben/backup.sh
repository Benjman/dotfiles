#!/usr/bin/env bash
# set -e

[ $# -eq 0 ] && echo 2>&1 "No backup target provided. Exiting."
[ ! -d ~/.backups ] && mkdir ~/.backups

# trim trailing slash, if one exists
path=${1%/}
# get value of last slash
name="${path##*/}"
# date formatted string
date_str=$(date +"%Y%m%d%H%M%S")

dest=~/.backups/$name-$date_str-backup

if [ -d $1 ]
then
	cp -r $path ~/.backups/$name-$date_str-backup
else
	cp $path ~/.backups/$name-$date_str-backup
fi

echo "Backed up $path to $dest"
