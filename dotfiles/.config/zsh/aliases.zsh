#!/usr/bin/env zsh

# date calculators
alias ddiff="dateutils.ddiff -f '%Y years %d days'"
alias daysuntil="dateutils.ddiff -f '%Y years %d days' today"

# system management
alias plug='vim +silent +"PackerInstall" +qall && vim +silent +"PackerClean" +qall'
alias upgrade='sudo apt update && sudo apt upgrade -y && sudo apt-get autoremove'
alias hur="htop -u $USER"
alias buildnvim="make distclean; make -j8 CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=$HOME/.local install"

# CLI
alias ll="exa -al --header --time-style long-iso"
alias ls="exa"
alias mv="mv -i"  # always prompt if overwriting a file
alias v="nvim"
alias randpass="openssl rand -base64 32"
alias jj="cd /stor/home/rybarskj/work/jjjenes"

# rando
alias brown="play -c 2 --null synth brownnoise reverb bass 6 treble -3 > /dev/null 2>&1"
alias sum="awk '{s+=\$1} END { print s }'"
