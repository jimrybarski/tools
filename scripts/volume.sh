#!/bin/sh

sink=$(pactl list | grep "Sink #" | sed 's/Sink #//')

command=$1

if [ $command = "raise" ]; then
    pactl set-sink-volume $sink +5%
elif [ $command = "lower" ]; then
    pactl set-sink-volume $sink -5%
elif [ $command = "mute" ]; then
    pactl set-sink-mute $sink toggle
fi


