#!/bin/bash

set -euo pipefail

image="$HOME/pictures/wallpaper-images/current-image"

if [[ ! -e $image ]]; then
    # there's no background image set, so just lock the screen
    i3lock --ignore-empty-password --color 000000 
    exit 0
fi

lock_image="$HOME/pictures/wallpaper-images/$(basename $(readlink $image)).lock_image.png"

if [[ ! -f $lock_image && -f $image ]]; then
  resolution=$(xrandr | grep current | perl -n -e '/.*current (\d+) x (\d+).*/ && print "$1x$2"')
  convert $image -kuwahara 10 -gravity center -background black -extent "$resolution" $lock_image 
  convert $lock_image -blur 2x3 $lock_image
fi

if [[ -f $lock_image ]]; then
  i3lock --ignore-empty-password -i $lock_image --color 000000
else
  i3lock --ignore-empty-password --color 000000
fi

