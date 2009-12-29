#!/bin/sh
# Nico Schottelius
# Date: Di Okt 18 00:02:17 CEST 2005
# Last Changed: -

GIT_DIR=~/git/cinit
OUTPUT=/home/user/nico/www/org/schottelius/linux/cinit/archives/cinit-snapshot.tar.bz2

set -e

cd "$GIT_DIR"
git-tar-tree $(git-log | head -n1 | awk '{ print $2 }') | bzip2 -9 -c > "$OUTPUT"
