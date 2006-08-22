#!/bin/sh
#
# Nico Schottelius <nico-linux //@// schottelius.org>
# Date: 21-Aug-2006
# Last Modified: -
#

while true; do
   ssh "$@"
   read foo
done
