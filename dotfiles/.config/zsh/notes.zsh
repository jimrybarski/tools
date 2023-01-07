#!/usr/bin/env zsh

# Edit markdown notes at remote server with zsh/neovim
function derive_note_filename () {
    filename=$1
    suffix=$2
    if [[ -z "$suffix" ]]; then
        suffix="md"
    fi
    echo "$filename.$suffix"
}

function edit_note () {
    filename=$(derive_note_filename $1 $2)
    ssh notes -t "/usr/local/bin/zsh -ic 'v $filename'"
}

alias en=edit_note

function echo_note () {
    filename=$(derive_note_filename $1 $2)
    ssh notes cat "/root/notes/$filename"
}
alias echon=echo_note

# notes
alias todo="edit_note todo"
alias tv="edit_note tv"
alias comedians="edit_note comedians"
alias sch="edit_note sch"
