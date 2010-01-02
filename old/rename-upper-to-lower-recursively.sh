#!/bin/sh
# Usage:
# cd /home/user/nico/Maildir/ethz/INBOX && find . -type d -exec ~/rename.sh {} \;

old="$1"
new="$(echo $old | tr '[A-Z]' '[a-z]')"

if [ "$new" != "$old" ]; then
   if [ ! -e "$old" ]; then
      echo "Skipping already renamed $old"
   else
      mv -v "$old" "$new"
   fi
fi
