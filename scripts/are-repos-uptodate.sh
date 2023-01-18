#!/usr/bin/env bash

pushd $HOME/tools > /dev/null
dotfiles_count=$(git status -s | wc -l)
popd > /dev/null
pushd $HOME/.password-store > /dev/null
password_count=$(git status | grep -P '(ahead)|(behind)')
popd > /dev/null
if [[ $dotfiles_count -gt "0" ]]; then
    echo "uncommitted changes in tools repo"
fi
if [[ -n $password_count ]]; then
    echo "uncommitted password change"
fi
