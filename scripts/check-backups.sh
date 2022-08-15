#!/usr/bin/zsh

set -euo pipefail

source $HOME/scripts/okabeito.sh

last_backup=$(tail -n 1 $HOME/.backup.log)
seconds=$(dateutils.ddiff --input-format "%Y-%m-%d %H:%M:%S%Z" "$last_backup" now -f "%S")
if [[ $seconds -gt 3600 ]]; then
    echo -e "No recent backup!\nNo backup!\n$vermillion"
else
    echo -e "Backup OK\nOK"
fi
