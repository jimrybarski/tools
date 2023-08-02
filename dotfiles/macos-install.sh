#!/bin/bash
set -euo pipefail

operating_system="$(uname)"

if [[ "$operating_system" == "Darwin" ]]; then
	mkdir -p "$HOME"/.config/nvim
	rm -rf "$HOME"/.config/nvim/*
	ln -s "$PWD"/.config/nvim "$HOME"/.config/nvim

	rm -rf "$HOME"/.config/zsh
	ln -s "$PWD"/.config/zsh "$HOME"/.config/zsh

	rm "$HOME"/.zshrc 
	ln -s "$PWD"/.zshrc "$HOME"/.zshrc
elif [[ "$operating_system" == "Linux" ]]; then
	for filename in `find . -type f | cut -c 3- | grep -v '\.git/' | grep -v "install.sh"`; do
	    >&2 echo "$filename"
	    if [ -z $filename ]; then
		    echo "Error! Empty filename. Something is very wrong with this script."
		exit 1
	    fi
	    rm -f "$HOME/$filename"
	    mkdir -p $(dirname "$HOME/$filename")
	    ln -s "$PWD/$filename" $HOME/$filename
	    >&2 echo "linked $filename to $HOME/$filename"
	done
fi

