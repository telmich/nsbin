#!/bin/sh

#PIDS=$(ps axuwww | awk '/\/usr\/bin\/btdownloadcurses/ { print $2 }')
PIDS=$(ps axuwww | awk '/\/usr\/bin\/btdownloadheadless/ { print $2 }')

kill -TERM $PIDS
sleep 10
kill -KILL $PIDS 2>/dev/null
