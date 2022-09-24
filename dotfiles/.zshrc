#!/usr/bin/env zsh

for script in "$HOME"/tools/dotfiles/.config/zsh/*.zsh; do
    source "$script"
done

custom_config="$HOME/tools/dotfiles/.config/zsh/local/$HOST.zsh"
if [[ -e "$custom_config" ]]; then
    source "$custom_config"
else
    >&2 echo "No custom config"
fi
