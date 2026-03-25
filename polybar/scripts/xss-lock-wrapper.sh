#!/bin/bash
# ~/.config/polybar/scripts/xss-lock-wrapper.sh

while true; do
  # check if any player is playing (firefox, chromium, mpv, etc.)
  if playerctl status 2>/dev/null | grep -q "Playing"; then
    sleep 30  # don't lock if video/audio is playing
  else
    # if not playing, run the actual locker
    i3lock --nofork
  fi
done

