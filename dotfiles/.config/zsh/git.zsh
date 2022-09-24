#!/usr/bin/env zsh

export REVIEW_BASE="main"

alias pull='git pull origin main'
alias pullm='git pull origin master'
alias push='git push origin main'
alias pushm='git push origin master'
alias gits='git status'
alias gitc="GIT_EDITOR='nvim +startinsert' git commit"
alias gitcs="GIT_EDITOR='nvim +startinsert' git commit -S"
