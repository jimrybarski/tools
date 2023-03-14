#!/usr/bin/env bash

if [[ -e "$HOME"/ssh/id_ed25519 ]]; then
    >&2 echo "key already exists: "$HOME"/ssh/id_ed25519"
    exit 1
fi

ssh-keygen -o -a 128 -t ed25519 -f "$HOME"/ssh/id_ed25519 -C "$@"
