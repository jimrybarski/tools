#/usr/bin/env zsh

setopt histignorealldups sharehistory extended_history append_history

HISTSIZE=10000
SAVEHIST=10000000
HISTFILE=$HOME/.zsh_history
bindkey '^R' history-incremental-search-backward
