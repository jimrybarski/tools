#!/bin/bash

error_file="$HOME/.errors.txt"

if [[ -e $error_file ]]; then
    head -n 1 $error_file
else
    echo ""
fi
