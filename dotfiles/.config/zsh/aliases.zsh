#!/usr/bin/env zsh

# date calculators
alias ddiff="dateutils.ddiff -f '%Y years %d days'"
alias daysuntil="dateutils.ddiff -f '%Y years %d days' today"

# system management
alias plug='vim +silent +"PackerInstall" +qall && vim +silent +"PackerClean" +qall'
alias upgrade='sudo apt update && sudo apt upgrade -y && sudo apt-get autoremove'
alias hur="htop -u $USER"

# CLI
alias ll="exa -al --header --time-style long-iso"
alias ls="exa"
alias mv="mv -i"  # always prompt if overwriting a file
alias v="nvim"
alias randpass="openssl rand -base64 32"
alias jj="cd $WORK/jjjenes"
