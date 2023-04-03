#!/usr/bin/env bash
#
# Installs a virtualenv that the Python scripts in this repo will use.

pushd "$HOME"/.local
python3 -m venv scriptenv
popd

"$HOME"/.local/scriptenv/bin/pip install -r "$HOME"/tools/scripts/requirements.txt
