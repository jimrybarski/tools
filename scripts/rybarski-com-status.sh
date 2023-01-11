#! /usr/bin/env bash
sleep 30  # wait a reasonable amount of time to ensure our internet connection is established. technically a race condition, but meh

output="$(curl -I https://www.rybarski.com 2>/dev/null | rg "200 OK")" 

if [[ -z "$output" ]]; then
    echo "rybarski.com down!"
fi
