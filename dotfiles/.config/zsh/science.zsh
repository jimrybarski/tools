#!/usr/bin/env zsh

# science
alias len="$HOME/code/seqtools-cli/target/release/seqtools-cli len"
alias rev="$HOME/code/seqtools-cli/target/release/seqtools-cli r"
alias rc="$HOME/code/seqtools-cli/target/release/seqtools-cli rc"
alias gc="$HOME/code/seqtools-cli/target/release/seqtools-cli gc"

function pfam () {
    rg -i $1 $DATA/pfam/all-domains.ssv
}

alias vpn='sudo openconnect vpn.utexas.edu -u rybarskj -b'
