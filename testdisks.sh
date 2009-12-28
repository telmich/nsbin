#!/bin/sh
# Nico Schottelius
# 2007-05-21
# Script used to test our fbsd dell servers
# => kills it
# => runs fine on my linux workstation :(

sequences=10
forks=50
count=140240
tmp=/tmp/testdisks
dev=/dev/zero

i=0

while [ "$i" -lt "$sequences" ]; do
   echo "Run: $i ..."
   k=0
   while [ "$k" -lt "$forks" ]; do
      file=$(mktemp "$tmp/$(basename $0).XXXXXXXXXXXXXXXX")
      ( dd if=$dev of="$file" bs=512 count=$count; rm -f "$file" ) &
      k=$(($k+1))
   done
   echo "Waiting ..."
   wait
   i=$(($i+1))
done
