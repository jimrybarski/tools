#!/usr/bin/env bash

# See if our dotfiles/scripts need to be synced
pushd $HOME/tools > /dev/null
dotfiles_count=$(git status -s | wc -l)
popd > /dev/null
if [[ $dotfiles_count -gt "0" ]]; then
    echo "uncommitted changes in tools repo"
fi

# See if we have any passwords to sync
pushd $HOME/.password-store > /dev/null
git fetch > /dev/null
password_count=$(git status | grep -P '(ahead)|(behind)')
popd > /dev/null
if [[ -n $password_count ]]; then
    echo "uncommitted password change"
fi
