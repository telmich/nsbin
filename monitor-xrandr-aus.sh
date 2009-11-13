#!/bin/sh
external="HDMI-2 VGA"

for R in $external; do
   xrandr --output $R --off
done
