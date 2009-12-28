#!/bin/sh

#set -x

#BASEDIR=$(dirname $0)
BASEDIR=$(pwd -P)
SDIR=$1

set -e
cd "$SDIR"
for file in *; do
   SUBDIR=$(echo $file | sed 's;.*/\(.*\);\1;' | sed 's/^\(.\).*/\1/' | tr 'A-Z' 'a-z')
   DDIR="$BASEDIR/$SUBDIR"
   echo "Creating $DDIR"
   mkdir -p "$DDIR"
   tar c "$file" | ( cd "$DDIR"; tar xv )
done
