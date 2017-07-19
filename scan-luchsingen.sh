#!/bin/sh

set -e
set -x

name=$1; shift

if [ "$#" -ge 1 ]; then
    source="ADF Duplex"
else
    source="ADF Front"
fi


#basename="$name-$(date +%F)"
basename="$name"
batchname="${basename}-%d.pnm"
pdfname="${basename}.pdf"

cd "$dir"
scanimage  -d 'fujitsu:ScanSnap S1500:16799' --mode lineart --resolution 300 \
	--source "$source" --batch="$batchname" || true

gm convert $(ls -v ${basename}*.pnm) "${basename}.pdf"

rm -f "${basename}"*.pnm
