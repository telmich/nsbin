#!/bin/sh
site='https://wiki.systems.ethz.ch/systems_utilisation?action=raw'

month="$(date +%m)"

# get reservations
# get current date
# do not change reservations that
# 
#  a) are permanent
#  b) are in the future
#  c) are empty
# 
# for all other reservations: delete
# 

curl --netrc ${site} | awk -F'\|\|' '$4 !~ /(permanent|time-frame|^ *$)/ { print $0 }'
