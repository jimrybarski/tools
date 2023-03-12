#!/usr/bin/env bash

# Installs a streaming video download tool

set -euo pipefail

if [[ -e "$HOME"/.local/ytdlpenv ]]; then
    exit 0
fi

mkdir -p "$HOME"/.local
pushd "$HOME"/.local >/dev/null 2>&1 
python3 -m venv ytdlpenv
ytdlpenv/bin/python3 -m pip install wheel
ytdlpenv/bin/python3 -m pip install yt-dlp
ln -s "$HOME"/.local/ytdlpenv/bin/yt-dlp "$HOME"/.local/bin/yt-dlp
popd >/dev/null 2>&1 
