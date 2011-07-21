#!/bin/sh
#
# Nico Schottelius <nico-linux@schottelius.org>
# Date: 29-Sep-2005
# Last Modified: -
#

[ $# -eq 1 ] || exit 23

PACKAGE=$1; shift
PREFIX=/usr/packages/$PACKAGE

# Search package, if multiple exists, ask for full name
# Search links
# Remove links
# Remove package

./configure --prefix=$PREfIX $@ && make
