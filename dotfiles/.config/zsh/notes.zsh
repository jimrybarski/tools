alias n='ssh notes'

# Edit markdown notes at remote server with zsh/neovim
function edit_note () {
    filename=$1
    suffix=$2

    if [[ -z "$suffix" ]]; then
	suffix="md"
    fi
    n -t "/usr/local/bin/zsh -ic 'v $filename.$suffix'"
}
alias en=edit_note

# notes
alias todo="edit_note todo"
alias tv="edit_note tv"
alias comedians="edit_note comedians"
alias sch="edit_note sch"
alias travel="edit_note checklist-travel"
