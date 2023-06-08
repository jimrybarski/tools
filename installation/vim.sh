#!/usr/bin/env bash

# install packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

mkdir -p "$HOME"/.local

# install neovim
git clone https://github.com/neovim/neovim.git
pushd neovim >/dev/null 2>&1 || exit 1
make -j8 CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX="$HOME"/.local install
popd >/dev/null 2>&1 || exit 1
