#!/bin/sh
# Enable connected, disable disconnected outputs

for output in $(xrandr -q | grep -v ^Screen | awk '/^[^ ]/ { print $1 }'); do
   xrandr --output $output --auto
done
