#!/usr/bin/env bash
# Creates a Python virtualenv with Jupyter and a bunch of math, biology, and visualization packages installed
 
mkdir -p $HOME/.local
pushd $HOME/.local 2>&1 >/dev/null
python3 -m venv jupyterenv
jupyterenv/bin/pip install wheel
jupyterenv/bin/pip install numpy scipy scikit-learn matplotlib biopython more-itertools 'seaborn[stats]' statsmodels jupyterlab pandas ipython jellyfish
ln -s $HOME/.local/jupyterenv/bin/jupyterlab $HOME/.local/bin/
popd 2>&1 >/dev/null
