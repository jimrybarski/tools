#!/usr/bin/env bash

# Doesn't allow shutting down via i3wm unless config files and scripts are committed and pushed

changes_needed=$(bash $HOME/scripts/are-repos-uptodate.sh)

if [[ ! -z $changes_needed ]]; then
	notify-send "commit changes first"
else
	shutdown now
fi
