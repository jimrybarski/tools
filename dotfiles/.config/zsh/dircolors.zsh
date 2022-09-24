#!/usr/bin/env zsh

# Linux has dircolors, FreeBSD has gdircolors
dircolors_exec=$(for binary in dircolors gdircolors; do p=$(which "$binary" | rg -v "not found"); if [[ -n "$p" ]]; then echo "$p"; break; fi; done)

if [[ -n "$dircolors_exec" ]]; then
    eval "$($dircolors_exec -b)"
fi
