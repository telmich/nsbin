#!/bin/sh

name=apache2

for proc in $(pgrep $name); do
   pmap -q -x $proc | \
      tail -n +2    | \
      awk '{
         oors=ORS;
         ORS=" ";
         print $2 "\t";
         i=7;
         while(i <= NF) {
            print $i;
            i=i+1;
         }
         ORS=oors;
         print "";
      }' | \
      sort -g | \
      tail -n 10
   echo From: ${proc}

done
