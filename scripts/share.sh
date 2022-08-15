#!/usr/bin/env zsh

set -euo pipefail

directory="$(uuidgen)"
mkdir $HOME/blog/content/$directory

cat << EOF > $HOME/blog/content/$directory/index.md
+++
title = ""
description = ""
[extra]
hidemenu = true
+++
<html><body>
EOF

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for filename in $@; do
    ln -s $(realpath "$filename") "$HOME/blog/content/$directory"
    echo "<a href=\"$filename\">$filename</a><br>" >> $HOME/blog/content/$directory/index.md
done
IFS=$SAVEIFS


echo "</body></html>" >> $HOME/blog/content/$directory/index.md

echo "Shared at: https://www.rybarski.com/$directory"
blogsync
