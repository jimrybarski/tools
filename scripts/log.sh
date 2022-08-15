#!/bin/bash
# Creates or searches my monolithic encrypted log file
# If this is the first time creating the file, it will still work but there will be an error printed to stdout. NBD.

set -euo pipefail

log_file="$HOME/documents/log.md.gpg"

function edit() {
    # edit the log file in neovim
    if [[ ! -e $(which nvim) ]]; then
        echo "nvim not installed"
        exit 1
    fi
    editor=$(which nvim)
    gpg --decrypt $log_file | EDITOR=$editor vipe | gpg --encrypt --recipient "James Rybarski" | sponge $log_file
}

function view() {
    # read-only viewing and search in bat with markdown highlighting
    gpg --decrypt $log_file | sponge | bat -l md
}

case $1 in
    "edit") 
        edit;;
    "view") 
        view;;
    *)
        echo "Invalid log.sh command";;
esac
