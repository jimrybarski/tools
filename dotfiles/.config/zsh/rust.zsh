#!/usr/bin/env zsh

alias cbr='cargo build --release'
alias cc='cargo check'
alias ct='cargo test'
alias cba='cargo test && cargo build --release && cargo clippy'
# recursively format all Rust source files
alias fmt="fd '\.rs$' -x rustfmt"
