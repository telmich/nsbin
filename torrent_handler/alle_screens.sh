#!/bin/sh

for screen in $(screen -ls | awk '/Detached/ { print $1 }'); do
   echo screen -Ux $screen;
   screen -Ux $screen;
done
