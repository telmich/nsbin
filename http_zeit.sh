#!/bin/sh
# Nico Schottelius

if [ $# -ne 1 ]; then
   echo "$0 URL"
   exit 1
fi

date
curl -s $1 >/dev/null
date
