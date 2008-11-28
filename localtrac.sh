#!/bin/sh
tracdir="$HOME/privat/computer/trac"
basedir=$(basename "$tracdir")

tracd --basic-auth="$basedir,$tracdir/.htpasswd,Private" \
      --port 8000 \
      $tracdir
#      --hostname 127.0.0.1 \
