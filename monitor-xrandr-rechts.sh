#!/bin/sh

L=LVDS1

xrandr --output $L --auto

external="VGA1 HDMI1 DP1 HDMI2 DP2 DP3 HDMI-2 VGA"

for R in $external; do
   xrandr --output $R --auto --right-of $L
done
