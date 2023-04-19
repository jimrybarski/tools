#!/usr/bin/env zsh

# Finds files in the current directory with spaces and replaces the spaces with underscores
function fixspaces() {
    for file in *' '*; 
        do mv -- "$file" "${file// /_}"; 
    done
}

function cpod() {
    python3 $HOME/documents/chinese/cpod.py < $HOME/downloads/vocabulary_export.csv | sort -u > $HOME/documents/chinese/vocab.tsv
}

# Remove a bad known SSH host
function remove_known_host() {
    ssh-keygen -f "$HOME/.ssh/known_hosts" -R "$1"
}
