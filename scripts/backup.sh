#!/bin/bash

# no pipefail since we want as many backups to succeed as possible
set -eu

failure=0

# push copies of local data
for directory in blog documents .password-store pictures music videos; do
    rsync -ru -e 'ssh -p 30 -i ~/.ssh/bk_ed25519' $HOME/$directory root@rybarski.com: 
    if [[ $? -ne "0" ]]; then
        failure=1
    fi
done

# pull down a local copy of my notes (which should not be edited)
scp -r -P 32 -i $HOME/.ssh/bk_ed25519 root@rybarski.com:~/notes $HOME/
if [[ $? -ne "0" ]]; then
	failure=2
fi

# pull down lotto data
pushd $HOME/lotto
bash pull-data.sh
if [[ $? -ne "0" ]]; then
    failure=3
fi
popd 

# log our success in a machine-readable format
if [[ $failure -eq "0" ]]; then
    d=$(date --rfc-3339=seconds)
    echo "$d" >> $HOME/.backup.log
fi
