#!/bin/sh

if [ "$#" -ne 1 ]; then
    echo "$0 package" >&2
    exit 1
fi

deps=$(pacman -Qi "$1" | awk -F: '/Depends On/ { print $2 }')

echo $1 -- $deps

alldeps=""

for dep in $deps; do
    [ "$dep" = "None" ] && continue

    pkg=$(echo $dep | sed 's/>=.*//')
    alldeps="$alldeps $("$0" "$pkg")"
done

echo "$alldeps"
