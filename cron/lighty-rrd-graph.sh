#!/bin/sh

RRDTOOL=/usr/bin/rrdtool
OUTDIR=/home/server/www/nico/org/schottelius/home/www/stats
INFILE=/home/server/www/rrd/lighttpd.rrd
OUTPRE=lighttpd-traffic

DISP="-v bytes --title TrafficWebserver \
        DEF:binraw=$INFILE:InOctets:AVERAGE \
        DEF:binmaxraw=$INFILE:InOctets:MAX \
        DEF:binminraw=$INFILE:InOctets:MIN \
        DEF:bout=$INFILE:OutOctets:AVERAGE \
        DEF:boutmax=$INFILE:OutOctets:MAX \
        DEF:boutmin=$INFILE:OutOctets:MIN \
        CDEF:bin=binraw,-1,* \
        CDEF:binmax=binmaxraw,-1,* \
        CDEF:binmin=binminraw,-1,* \
        CDEF:binminmax=binmax,binmin,- \
        CDEF:boutminmax=boutmax,boutmin,- \
        AREA:binmin#ffffff: \
        STACK:binminmax#f00000: \
        LINE1:binmin#a0a0a0: \
        LINE1:binmax#a0a0a0: \
        LINE2:bin#a0a735:incoming \
        GPRINT:bin:MIN:%.2lf \
        GPRINT:bin:AVERAGE:%.2lf \
        GPRINT:bin:MAX:%.2lf \
        AREA:boutmin#ffffff: \
        STACK:boutminmax#00f000: \
        LINE1:boutmin#a0a0a0: \
        LINE1:boutmax#a0a0a0: \
        LINE2:bout#a0a735:outgoing \
        GPRINT:bout:MIN:%.2lf \
        GPRINT:bout:AVERAGE:%.2lf \
        GPRINT:bout:MAX:%.2lf \
        "


$RRDTOOL graph $OUTDIR/$OUTPRE-hour.png -a PNG --start -14400 $DISP
$RRDTOOL graph $OUTDIR/$OUTPRE-day.png -a PNG --start -86400 $DISP
$RRDTOOL graph $OUTDIR/$OUTPRE-month.png -a PNG --start -2592000 $DISP

OUTPRE=lighttpd-requests

DISP="-v req --title RequestsperSecond -u 1 \
        DEF:req=$INFILE:Requests:AVERAGE \
        DEF:reqmax=$INFILE:Requests:MAX \
        DEF:reqmin=$INFILE:Requests:MIN \
        CDEF:reqminmax=reqmax,reqmin,- \
        AREA:reqmin#ffffff: \
        STACK:reqminmax#0e0e0e: \
        LINE1:reqmin#a0a0a0: \
        LINE1:reqmax#a0a0a0: \
        LINE2:req#00a735:requests"


$RRDTOOL graph $OUTDIR/$OUTPRE-hour.png -a PNG --start -14400 $DISP
$RRDTOOL graph $OUTDIR/$OUTPRE-day.png -a PNG --start -86400 $DISP
$RRDTOOL graph $OUTDIR/$OUTPRE-month.png -a PNG --start -2592000 $DISP
