#!/usr/bin/env bash

if [[ -n "$(which shellcheck)" ]]; then
    exit 0
fi

if [[ "$(uname)" == "FreeBSD" ]]; then
    pkg install hs-ShellCheck
elif [[ "$(uname)" == "Linux" ]]; then
    pushd "$HOME"/.local >/dev/null 2>&1 || exit 1
    wget https://github.com/koalaman/shellcheck/releases/download/v0.9.0/shellcheck-v0.9.0.linux.x86_64.tar.xz
    tar -xf shellcheck-v0.9.0.linux.x86_64.tar.xz
    ln -s "$HOME"/.local/shellcheck-v0.9.0/shellcheck "$HOME"/.local/bin/shellcheck
    popd >/dev/null 2>&1 || exit 1
fi
