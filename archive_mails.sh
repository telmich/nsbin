#!/bin/sh
# Nico Schottelius
# clean current mailbox, so imap connections are faster

set -e

maildir="$HOME/Maildir"
curdir="$maildir/cur"
date=$(date +%Y-%m-%d)
archiv="$HOME/mail-archiv"
ddir="${archiv}/${date}/"

mkdir -p "$ddir"

find "$curdir" -type f -exec mv {} "$ddir" \;
