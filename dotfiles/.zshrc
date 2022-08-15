#!/usr/bin/env zsh

export LC_ALL="en_US.UTF-8"
export LANG="en_US" # Set up the prompt
PROMPT="%B%F{green}%n@%m%f%b [%*] [%(?.%F{green}√%f.%F{red}%?%f)] %d %F{blue}$%f "

# vi mode
bindkey -v 
# only wait 0.1 sec before entering normal mode
export KEYTIMEOUT=0.1

EDITOR=$(which vim)

# Linux has dircolors, FreeBSD has gdircolors
dircolors_exec=$(which dircolors || which gdircolors)
eval "$($dircolors_exec -b)"

umask 027

# Make terminal compatible with FreeBSD and Linux servers
export TERM=xterm-256color zsh
export GPG_TTY=$(tty)
export REVIEW_BASE="main"

# ============================================
#       KEEP THIS AT THE VERY END
# ============================================
for script in $HOME/.config/zsh/*.zsh; do
    source $script
done

# Load machine-specific config files
custom_config="$HOME/.config/zsh/local/$HOST.zsh"
if [[ -e $custom_config ]]; then
    source $custom_config
else
    >&2 echo "No custom config"
fi
