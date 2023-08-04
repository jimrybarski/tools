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
    osname=$(uname)
    if [[ "$osname" != "Darwin" ]]; then
        ssh notes -t "/usr/local/bin/zsh -ic 'mkdir -p ~/notes/$directory && v ~/notes/$filename'"
    else
        mkdir -p "$HOME/notes/$directory" && v "$HOME/notes/$filename"
    fi
}

alias en=edit_note

function edit_paper () {
    filename=$(derive_note_filename $1)
    directory=$(dirname $filename)
    echo "filename: $filename"
    osname=$(uname)
    if [[ "$osname" != "Darwin" ]]; then
        ssh notes -t "/usr/local/bin/zsh -ic 'mkdir -p ~/papers/$directory && if [[ ! -e ~/papers/$filename ]]; then echo $1 > ~/papers/$filename; fi; v ~/papers/$filename'"
    else
        # since DOIs have a forward slash, we'll have a directory for each publisher. we could alternatively change the
        # slash to something else but I think this is kinda neat and not worth solving
        echo "making dir $HOME/papers/$directory"
        mkdir -p "$HOME/papers/$directory"
        if [[ ! -e "$HOME/papers/$filename" ]]; then
            echo "writing DOI $1 to file $HOME/papers/$filename"
            echo $1 > "$HOME/papers/$filename"
            nvim "$HOME/papers/$filename"
        else
            nvim "$HOME/papers/$filename"
        fi
    fi
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
alias plotw="echow | $HOME/.local/scriptenv/bin/python $HOME/tools/scripts/plot-measurement-progress.py"

function wp() {
    w $1
    plotw
}

# notes
alias todo="edit_note todo"
alias tv="edit_note tv"
alias comedians="edit_note comedians"
alias j="edit_note $(date +'%F')"
