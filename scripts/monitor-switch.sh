#!/bin/bash
# modified from https://faq.i3wm.org/question/5312/how-to-toggle-onoff-external-and-internal-monitors.1.html

# this script will toggle which monitors are on. after booting, all monitors will be clones of the main laptop monitor.
# after each execution, we cycle through the following modes: 
#  - external monitor only (work mode)
#  - external and laptop on but not clones (presentation mode)
#  - laptop monitor only

set -euo pipefail

# we need to include aliases so we can use the commands to adjust screen brightness
shopt -s expand_aliases
source ~/.bash_aliases.d/screen-brightness.sh

INTERNAL_OUTPUT=$(xrandr | grep connected | grep -v disconnected | head -n 1 | awk '{print $1}')
EXTERNAL_OUTPUT=$(xrandr | grep connected | grep -v disconnected | tail -n 1 | awk '{print $1}')
echo "in $INTERNAL_OUTPUT" >> /tmp/monitor.log
echo "ex $EXTERNAL_OUTPUT" >> /tmp/monitor.log

# both monitors are on by default after boot
if [ ! -f "/tmp/monitor_mode.dat" ] ; then
  monitor_mode="all"
# otherwise read the value from the file
else
  monitor_mode=`cat /tmp/monitor_mode.dat`
fi

if [ $monitor_mode = "all" ]; then
        monitor_mode="EXTERNAL"
        day
        xrandr --output $INTERNAL_OUTPUT --off --output $EXTERNAL_OUTPUT --auto
elif [ $monitor_mode = "EXTERNAL" ]; then
        monitor_mode="PRESENTATION"
        bright
        xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --auto --left-of $INTERNAL_OUTPUT
else 
        monitor_mode="all"
        night
        xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --off
fi

echo "${monitor_mode}" > /tmp/monitor_mode.dat
