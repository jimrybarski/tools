#!/usr/bin/env bash

minutes="7m"
notify-send "Timer set for $minutes"
sleep "$minutes"
notify-send \
    --icon "$HOME/tools/scripts/tea.png" \
    --urgency critical \
    "Tea is ready"
