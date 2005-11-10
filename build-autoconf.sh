#!/bin/sh
#
# Nico Schottelius <nico-linux@schottelius.org>
# Date: 17-Sep-2005
# Last Modified: -
#

[ $# -eq 1 ] || exit 23

PACKAGE=$1; shift
PREFIX=/usr/packages/$PACKAGE

./configure --prefix=$PREfIX $@ && make
