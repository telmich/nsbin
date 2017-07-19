#!/bin/sh
# Nico Schottelius
# clean current mailbox, so imap connections are faster

set -e

maildir="/home/server/mail/schottelius.org/nico/"
curdir="$maildir/cur"
date=$(date +%Y-%m-%d)
archiv="/home/user/nico/mail-archiv"
ddir="${archiv}/${date}/"

mkdir -p "$ddir"

find "$curdir" -type f -exec mv {} "$ddir" \;

