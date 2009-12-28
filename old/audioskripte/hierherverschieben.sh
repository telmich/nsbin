#!/bin/sh

#set -x

BASEDIR=$(dirname $0)
FILE=$1

SUBDIR=$(echo $FILE | sed 's;.*/\(.*\);\1;' | sed 's/^\(.\).*/\1/' | tr 'A-Z' 'a-z')

DDIR="$BASEDIR/$SUBDIR"
set -e
echo "Creating $DDIR"
mkdir -p "$DDIR"
echo "Moving $FILE to $DDIR"
mv "$FILE" "$DDIR"
