#!/usr/bin/env zsh

function mp3() {
    $HOME/.local/bin/yt-dlp --extract-audio --audio-format mp3 "$1" -o "$HOME/music/%(title)s.%(ext)s"
}

function yv() {
    $HOME/.local/bin/yt-dlp "$1" -o "$HOME/videos/%(title)s.%(ext)s"
}
