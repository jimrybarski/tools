#!/usr/bin/env bash

status=$(bash $HOME/scripts/vpn-status.sh | head -n 1)
if [ "$status" = "VPN off" ]; then
    $@
else
    notify-send -i starred "nope"
fi

