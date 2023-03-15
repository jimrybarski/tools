#!/usr/bin/env bash

mkdir -p "$HOME"/.local

git clone https://github.com/latex-lsp/texlab.git "$HOME"/.local/texlab

pushd "$HOME"/.local/texlab >/dev/null 2>&1 || exit 1
cargo build --release
ln -s "$HOME"/.local/texlab/target/release/texlab "$HOME"/.local/bin/
popd >/dev/null 2>&1 || exit 1
