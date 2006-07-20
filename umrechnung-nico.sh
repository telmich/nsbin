#!/bin/sh

WAEHRUNG="EUR DEM USD DKK GBP JPY CHF"

for W in $WAEHRUNG
do
   curl -s "http://de.finance.yahoo.com/m5?a=1&s=EUR&t=$W" | sed '/<\/td><\/tr><input name=c type=hidden value=0><\/table><input type=submit value=umrechnen><\/form>/{s/.*<td>\(.*\)<\/td><td><b>.*<\/b>$/\1/;s/,/./; s/\(.*\)/'$W,'\1\;/; q}; d'


# http://de.finance.yahoo.com/q?d=t&s=XAUUSD=X

done
