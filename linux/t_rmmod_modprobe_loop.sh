#!/bin/sh
# Nico Schottelius
# Script to test if a module can be reloaded
# usage: <module> <cmd>
# example: iwlagn "sleep 0.2"

mod="$1"; shift
cmd="$1"; shift

while true; do
   loaded=$(lsmod | grep ^${mod})

   if [ "$loaded" ]; then
      rmmod -v "$mod"
   else
      modprobe -v "$mod"
   fi
   echo "Calling $cmd ..." 
   eval $cmd
done

