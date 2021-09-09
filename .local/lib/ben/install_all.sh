#!/usr/bin/env bash
set e

# This script will set up a new ubuntu environment
for f in ~/.config/ben/installs/*.sh; do
	/usr/bin/env bash $f
done
