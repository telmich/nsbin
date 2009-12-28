#!/bin/sh
# Nico Schottelius
# 2009-07-24
# Connect to a terminal server

opts="-u nicosc -d d -g 1260x780"
# use xrandr -q | awk  '/\*/ { print $1 }' later

rdesktop $opts sgterm1.inf.ethz.ch || rdesktop $opts sgterm2.inf.ethz.ch
