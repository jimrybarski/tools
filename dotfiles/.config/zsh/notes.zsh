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
    directory=$(dirname $filename)
    ssh notes -t "/usr/local/bin/zsh -ic 'mkdir -p ~/notes/$directory && v ~/notes/$filename'"
}

alias en=edit_note

function edit_paper () {
    filename=$(derive_note_filename $1 $2)
    directory=$(dirname $filename)
    ssh notes -t "/usr/local/bin/zsh -ic 'mkdir -p ~/papers/$directory && if [[ ! -e ~/papers/$filename ]]; then echo $1 > ~/papers/$filename; fi; v ~/papers/$filename'"
}

alias ep=edit_paper

function echo_note () {
    filename=$(derive_note_filename $1 $2)
    ssh notes cat "/root/notes/$filename"
}
alias echon=echo_note

function log_measurement () {
    data="$(date +'%F') $1"
    ssh notes -t "echo $data >> ~/notes/measurements.ssv"
}

alias w=log_measurement

alias echow="ssh notes 'cat ~/notes/measurements.ssv'"

# notes
alias todo="edit_note todo"
alias tv="edit_note tv"
alias comedians="edit_note comedians"
alias sch="edit_note $(date +'%F')"
