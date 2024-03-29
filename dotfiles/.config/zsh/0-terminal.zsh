#!/usr/bin/env zsh

export LC_ALL="en_US.UTF-8"
export LANG="en_US" # Set up the prompt
export TERM=xterm-256color zsh

PROMPT="%B%F{green}%n@%m%f%b [%*] [%(?.%F{green}√%f.%F{red}%?%f)] %d %F{blue}$%f "
if [[ -e $HOME/.ghcup/bin ]]; then
    export PATH="$HOME/.local/bin:$HOME/.ghcup/bin:$HOME/.cargo/bin:$PATH"
else
    export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
fi
    
if [[ -e "$HOME"/.local/miniconda3/bin ]]; then
    export PATH="$PATH:$HOME/.local/miniconda3/bin"
fi

if [[ -e "$HOME"/homebrew/bin ]]; then
    export PATH="$PATH:$HOME/homebrew/bin"
fi

if [[ -e "$HOME"/Library/Python/3.9/bin ]]; then
    export PATH="$PATH:$HOME/Library/Python/3.9/bin"
fi

# enable vi mode
bindkey -v 
# only wait 0.1 sec before entering normal mode
export KEYTIMEOUT=0.1

# try to pick the optimal editor, falling back to increasingly worse options
EDITOR=$(for binary in nvim vim vi nano; do p=$(which $binary | rg -v "not found"); if [[ -n $p ]]; then echo $p; break; fi; done)

umask 027
