#!/bin/bash
# Toggle xss-lock running state

LOCK_CMD="xss-lock --transfer-sleep-lock -- xssproxy i3lock --nofork"

case "$1" in
  toggle)
    if pgrep -x xss-lock >/dev/null; then
      pkill -x xss-lock
      xset s 300 300     # re-enable after 5 mins
      xset +dpms
    else
      # Run in background and detach from polybar
      nohup $LOCK_CMD >/dev/null 2>&1 &
      playerctl pause 2>/dev/null &
      xset s off -dpms   # disable dimming
    fi
    ;;
  status)
    if pgrep -x xss-lock >/dev/null; then
      echo "%{F#f9e2af}   "   # locked / active icon
    else
      echo "%{F#f9e2af}   "   # unlocked / disabled icon
    fi
    ;;
esac

