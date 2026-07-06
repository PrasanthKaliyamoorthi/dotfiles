#!/bin/bash
while true; do
    if playerctl status 2>/dev/null | grep -q "Playing"; then
        # Inhibit idle (reset timer)
        xset -dpms
        xset s off
    else
        # Re-enable idle
        xset +dpms
        xset s on
    fi
    sleep 10
done

