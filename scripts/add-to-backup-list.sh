#!/usr/bin/env bash

# Appends a filename to the list of things we want to back up. Can be a relative path or full path.


backup_file="$HOME/.config/backup-list.txt"
gibibyte="1073741824"

if [ ! -e $1 ]; then
    echo "$1 does not exist"
else
    filesize=$(stat --format="%s" $1)

    # Warn if file is larger than a gibibyte
    if [[ "$filesize" -ge "$gibibyte" && -z "$2" ]]; then
        echo "Error! File is larger than 1 GB!"
        echo "To back this file up, run: backup $1 f"
        exit 1
    fi

    full_path=$(readlink -f $1)
    echo $full_path >> $backup_file
    sort -uo $backup_file $backup_file
fi
