#!/usr/bin/env bash

if [[ -z "$1" ]]; then
    >&2 echo "Usage: bash doi.sh YOUR_DOI_HERE"
    exit 1
fi

curl -LH "Accept: text/bibliography; style=bibtex" http://dx.doi.org/"$1"
