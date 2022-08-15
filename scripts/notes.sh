#!/bin/bash

mkdir -p $HOME/notes
nvim $HOME/notes/$(date -u +'%Y%m%d-%H%M%S').md
