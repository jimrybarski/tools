# date calculators
alias ddiff="dateutils.ddiff -f '%Y years %d days'"
alias daysuntil="dateutils.ddiff -f '%Y years %d days' today"

# system management
alias plug='vim +silent +"PlugInstall --sync" +qall && vim +silent +"PlugClean" +qall'
alias upgrade='sudo apt update && sudo apt upgrade -y && sudo apt-get autoremove'

# CLI configuration
alias ll="exa -al --header --time-style long-iso"
alias ls="exa"
alias mv="mv -i"  # always prompt if overwriting a file
alias v="vim"

#programming
alias eba=". env/bin/activate"
alias randpass="openssl rand -base64 32"

