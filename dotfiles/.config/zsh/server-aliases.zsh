#!/usr/bin/env zsh

alias sf="ssh freeboxroot"
alias sm="ssh marble"
alias ss="ssh stampede"
alias sw="ssh wilke"
alias sw2="ssh wilke2"

function memscp () {
    scp -r wilke:~/work/final-mempads/$1 $2
}
