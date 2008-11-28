#!/bin/sh
#

while true; do echo currenttrack | xmms-shell  | sed 's/Current song: //'; sleep 5; done
