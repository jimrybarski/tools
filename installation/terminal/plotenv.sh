#!/usr/bin/env bash
#
# Installs a virtualenv that the Python scripts in this repo will use.

pushd "$HOME"/.local || exit 1
python3 -m venv scriptenv
popd || exit 1

"$HOME"/.local/scriptenv/bin/pip install -r "$HOME"/tools/scripts/requirements.txt
