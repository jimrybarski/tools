#!/usr/bin/env bash

set -euo pipefail

mkdir -p "$HOME"/.local

if [[ ! -e "$HOME"/.local/neovim ]]; then
	git clone https://github.com/neovim/neovim.git "$HOME"/.local/neovim
fi

pushd "$HOME"/.local/neovim
make CMAKE_INSTALL_PREFIX=$HOME/.local/nvim  CMAKE_BUILD_TYPE=Release install
popd
rm "$HOME"/.local/bin/nvim
ln -s "$HOME"/.local/neovim/build/bin/nvim "$HOME"/.local/bin/
