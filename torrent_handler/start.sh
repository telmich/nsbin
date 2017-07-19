#!/bin/sh

#set -x


TOPABS=$(cd $(dirname $0); pwd -P)
TORDIR="$TOPABS/torrents"
LOGDIR="$TOPABS/logs"
OUTDIR="$TOPABS/out"
DNLOADR="$TOPABS/downloader.sh"


rm -f "${LOGDIR}/"*
# place downloads into current diretory/out
cd "$OUTDIR"

for torrent in ${TORDIR}/*; do
   logfile="$LOGDIR/$(basename "$torrent")"
   #echo screen -d -m btdownloadcurses --max_upload_rate 1 "$torrent" G "$logfile"
   #screen -d -m btdownloadheadless --max_upload_rate 1 "$torrent" > "$logfile"
   screen -d -m "$DNLOADR" "$torrent" "$logfile"
done
