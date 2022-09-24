#!/usr/bin/env bash

pushd $HOME/tools > /dev/null
dotfiles_count=$(git status -s | wc -l)
popd $HOME/tools > /dev/null
if [[ $dotfiles_count -gt "0" ]]; then
    echo "uncommitted changes in tools repo"
fi
