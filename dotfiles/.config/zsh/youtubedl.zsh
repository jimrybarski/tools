#!/usr/bin/env zsh

function mp3() {
    $HOME/.local/bin/youtubedl-env/bin/youtube-dl --extract-audio --audio-format mp3 "$1" -o "$HOME/music/%(title)s.%(ext)s"
}

function yv() {
    $HOME/.local/bin/youtubedl-env/bin/youtube-dl "$1" -o "$HOME/videos/%(title)s.%(ext)s"
}
