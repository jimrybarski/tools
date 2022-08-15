#!/bin/bash

# Calculates how many more glasses of water I need to drink each day
NUM_GLASSES_PER_DAY=4

LOGFILE=$HOME/.local/water.log
touch $LOGFILE
TODAY=$(date +"%Y-%m-%d")
count=$(tail -n $NUM_GLASSES_PER_DAY $LOGFILE | grep $TODAY | wc -l)
let remaining=$NUM_GLASSES_PER_DAY-$count
echo $remaining
