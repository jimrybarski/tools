#!/bin/bash

set -euo pipefail

xdg-open $HOME/documents/openintro-statistics.pdf &
cd $HOME/stats
env/bin/jupyter-notebook &
