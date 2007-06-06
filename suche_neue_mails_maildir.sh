#!/bin/sh
#
# Nico Schottelius <nico-linux //@// schottelius.org>
# Date: 06-Jun-2007
# Last Modified: -
# Description: Search for new mailboxes (and later display them via dialog)
#

basedir=~/Maildir
tmp=$(mktemp /tmp/$(basename $0).XXXXXXXXXXXX)

find "$basedir" -name new -type d > "$tmp"

while read dir; do
   is_new=$(ls "${dir}" | head -n1)
   if [ "$is_new" ]; then
      echo "New in $dir"
   fi
done < "$tmp"

rm -f "$tmp"
