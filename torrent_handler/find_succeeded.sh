#!/bin/sh
# Nico Schottelius
# find succussfully downloaded torrents

TOPABS=$(cd $(dirname $0); pwd -P)
TORDIR="$TOPABS/torrents"
LOGDIR="$TOPABS/logs"
OUTDIR="$TOPABS/out"
SAVEDIR="$TOPABS/fertig"
SAVETOR="$SAVEDIR/torrents"
SEARCHTERM='time left:      Download Succeeded!'
TESTLINES="20"

# place downloads into current diretory/out
cd "$LOGDIR"

#for torrent in ${TORDIR}/*; do
for log in *; do
   tail -n${TESTLINES} "$log" | grep -q "$SEARCHTERM"  >/dev/null
   if [ "$?" -eq 0 ]; then
      echo "$log" finished.
      file=$(tail -n${TESTLINES} "$log" | awk -F: '/^download to:/ { print $2 }' | tail -n1 | sed 's;^ */;/;')
      mv "${file}" "${SAVEDIR}"
      mv "${TORDIR}/${log}" "${SAVETOR}"
      rm "$log"
   fi
done
