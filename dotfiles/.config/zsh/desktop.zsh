#!/usr/bin/env zsh

# screen brightness
alias bright='redshift -o -P -O 5000 -b 1.0'
alias day='redshift -o -P -O 3800 -b 0.75'
alias night='redshift -o -P -O 2500 -b 0.60'

function wallpaper() {
  directory=$(pwd -P)
  current_symlink=$HOME/pictures/wallpaper-images/current-image
  rm -f $current_symlink
  ln -s $directory/$1 $current_symlink
}

function o() {
    if [ $# -eq 0 ]; then
        xdg-open .  > /dev/null 2>&1
    else
        xdg-open "$@" > /dev/null 2>&1
    fi
}

function otp() {
    code=$(pass otp/$1)
    while true; do
        sleep 1;
        oathtool --totp -b $code | xclip -i -selection clipboard
    done
}
