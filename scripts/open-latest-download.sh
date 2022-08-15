#/usr/bin/env bash

# Opens the most-recently modified file in my downloads folder

filename=$(exa -s modified $HOME/downloads | tail -n 1)
echo "$filename"

if [ -z "$filename" ]; then
    notify-send -i starred "No files in download folder"
else
    xdg-open "$HOME/downloads/$filename" > /dev/null 2>&1
fi
