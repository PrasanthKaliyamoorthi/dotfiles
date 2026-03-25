#!/bin/bash

OUTPUT="DisplayPort-0"
STEP=0.05

show() {
  current=$(xrandr --verbose | awk '/Brightness/ {print $2; exit}')
  percentage=$(awk -v c="$current" 'BEGIN { printf("%{F#f9e2af} %{F#ffffff}%2.0f%% \n", c * 100) }' )
  echo "$percentage"
}

case "$1" in
  up)
    current=$(xrandr --verbose | awk '/Brightness/ {print $2; exit}')
    new=$(awk -v c="$current" -v s="$STEP" 'BEGIN {n=c+s; if(n>1) n=1; print n}')
    xrandr --output "$OUTPUT" --brightness "$new"
    show
    ;;
  down)
    current=$(xrandr --verbose | awk '/Brightness/ {print $2; exit}')
    new=$(awk -v c="$current" -v s="$STEP" 'BEGIN {n=c-s; if(n<0.1) n=0.1; print n}')
    xrandr --output "$OUTPUT" --brightness "$new"
    show
    ;;
  show|*)
    show
    ;;
esac

