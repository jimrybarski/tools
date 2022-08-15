pushd $HOME/dotfiles > /dev/null
dotfiles_count=$(git status -s | wc -l)
if [[ $dotfiles_count -gt "0" ]]; then
    dotfiles_string="dotfiles"
else
    dotfiles_string=""
fi

pushd $HOME/scripts > /dev/null
scripts_count=$(git status -s | wc -l)
if [[ $scripts_count -gt "0" ]]; then
    scripts_string="scripts"
else
    scripts_string=""
fi
popd > /dev/null
popd > /dev/null

if [[ ! -z "$dotfiles_string$scripts_string" ]]; then
    echo "commits needed for: $dotfiles_string $scripts_string"
fi
