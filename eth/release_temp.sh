#!/bin/sh

file=$1
host=free.ethz.ch
dir=public_html/temp/
url="http://people.inf.ethz.ch/~nicosc/temp"

[ -z "$file" ] && exit 1

bfile="$(basename "$file")"

scp "$file" "${host}:$dir"
ssh $host "chmod a+r $dir/$bfile"

echo "Pre-released ${url}/${bfile}"
