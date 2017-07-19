#! /bin/bash

WDIR=/root/bin/stats
TODAY=$(/bin/date +%s)
WWWDIR=/home/server/www/nico/org/schottelius/tech/stats

## extract mem values from /proc/meminfo

RAM=`grep MemFree /proc/meminfo|tr -s [:blank:]|cut -f2 -d" "`
SWAP=`grep SwapFree /proc/meminfo|tr -s [:blank:]|cut -f2 -d" "`
#SWAP=`grep  /proc/meminfo|tr -s [:blank:]|cut -f2 -d" "`

#echo $SWAP

## write data into the RRD

rrdtool update $WDIR/rrdtool/memory.rrd $TODAY:$RAM:$SWAP

## draw the graph

rrdtool graph $WWWDIR/memory.gif \
--start -86400 \
--vertical-label "kBytes free" \
-w 600 -h 200 \
DEF:ram=$WDIR/rrdtool/memory.rrd:ram:AVERAGE \
DEF:swap=$WDIR/rrdtool/memory.rrd:swap:AVERAGE \
AREA:ram#00ff00:"RAM" \
LINE1:swap#0000ff:"Swap"
