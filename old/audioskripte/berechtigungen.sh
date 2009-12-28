#!/bin/sh

DIR=$(dirname $0)

chown -R :mpd "$DIR"
find "$DIR" -type d -exec chmod g=rx  {} \;
find "$DIR" -type f -exec chmod g=r   {} \;
