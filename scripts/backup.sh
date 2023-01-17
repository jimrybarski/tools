#!/usr/bin/env bash

# no pipefail since we want as many backups to succeed as possible
set -eu

failure=0

# push copies of local data
# TODO: skip this if the host isn't "desktop"
for directory in blog documents pictures music videos; do
    rsync -ru -e 'ssh -p 30 -i ~/.ssh/bk_ed25519' $HOME/$directory root@rybarski.com: 
    if [[ $? -ne "0" ]]; then
        failure=1
    fi
done

# pull down a local backup of my notes and archive them.
# these are never meant to be used/edited unless the server is lost
# TODO: make this save into a tar.gz file with the day's date in the filename
scp -r -P 32 -i $HOME/.ssh/bk_ed25519 root@rybarski.com:~/notes $HOME/
if [[ $? -ne "0" ]]; then
	failure=2
fi

# log our success in a machine-readable format
if [[ $failure -eq "0" ]]; then
    d=$(date --rfc-3339=seconds)
    echo "$d" >> $HOME/.backup.log
fi
