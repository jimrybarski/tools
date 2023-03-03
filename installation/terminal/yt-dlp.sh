#!/usr/bin/env bash
# Installs a streaming video download tool

set -euo pipefail

mkdir -p $HOME/.local
pushd $HOME/.local
python3 -m venv ytdlpenv
ytdlpenv/bin/python3 -m pip install wheel
ytdlpenv/bin/python3 -m pip install yt-dlp
ln -s $HOME/.local/ytdlpenv/bin/yt-dlp $HOME/.local/yt-dlp
popd
