#!/bin/sh

torrent="$1"
logfile="$2"
echo "Logging to $logfile"

#btdownloadheadless --max_upload_rate 1 "$torrent" > "$logfile" 2>&1
btdownloadheadless --display_interval 10 --max_upload_rate 1 "$torrent" 2>&1 | tee "$logfile"
