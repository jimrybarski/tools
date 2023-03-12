#!/usr/bin/env bash

mkdir -p "$HOME"/.local
pushd "$HOME"/.local >/dev/null 2>&1 || exit 1
git clone https://github.com/github/gitignore.git
popd >/dev/null 2>&1 || exit 1
