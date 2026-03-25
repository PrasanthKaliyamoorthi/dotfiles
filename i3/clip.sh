#!/bin/bash
# Kill existing processes
killall -q polybar xfce4-clipman

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar
polybar mybar &

# Wait for tray to exist, then launch clipman
sleep 2
xfce4-clipman &
