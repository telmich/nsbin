#!/bin/sh
# Nico Schottelius

external="$(cat ~/.x-monitors)"

for R in $external; do
   xrandr --output $R --off
done
