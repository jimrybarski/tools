#!/usr/bin/env bash
# Creates a Python virtualenv with Jupyter and a bunch of math, biology, and visualization packages installed
 
if [[ -e "$HOME"/.local/jupyterenv ]]; then
    exit 0
fi

mkdir -p "$HOME"/.local/bin

pushd "$HOME"/.local >/dev/null 2>&1 || exit 1
python3 -m venv jupyterenv
jupyterenv/bin/pip install wheel
jupyterenv/bin/pip install numpy scipy scikit-learn matplotlib biopython more-itertools 'seaborn[stats]' statsmodels jupyterlab pandas ipython jellyfish
ln -s "$HOME"/.local/jupyterenv/bin/jupyterlab "$HOME"/.local/bin/
popd >/dev/null 2>&1 || exit 1
