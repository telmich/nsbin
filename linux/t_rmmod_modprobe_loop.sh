#!/bin/sh
# Nico Schottelius
# Script to test if a module can be reloaded

mod="$1"; shift
cmd="$1"; shift

while true; do
   loaded=$(lsmod | grep ^${mod})

   if [ "$loaded" ]; then
      rmmod -v "$mod"
   else
      modprobe -v "$mod"
   fi
   
   $cmd
done

