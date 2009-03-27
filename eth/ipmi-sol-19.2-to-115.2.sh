#!/bin/sh
# 
# 2008      Nico Schottelius (nico-nsbin at schottelius.org)
# 
# This file is part of nsbin.
#
# nsbin is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# nsbin is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with nsbin. If not, see <http://www.gnu.org/licenses/>.
#
#
#

################################################################################
# standard vars
# Stolen from cconf
__pwd="$(pwd -P)"
__mydir="${0%/*}"; __abs_mydir="$(cd "$__mydir" && pwd -P)"
__myname=${0##*/}; __abs_myname="$__abs_mydir/$__myname"

host="$1"

set -x
ipmitool -H "$host" -I lanplus -U admin -P admin sol set enabled true
ipmitool -H "$host" -I lanplus -U admin -P admin sol set non-volatile-bit-rate 19.2
ipmitool -H "$host" -I lanplus -U admin -P admin sol set volatile-bit-rate 19.2

echo "configure bios:"
ipmitool -H "$host" -I lanplus -U admin -P admin sol activate

ipmitool -H "$host" -I lanplus -U admin -P admin sol set non-volatile-bit-rate 115.2
ipmitool -H "$host" -I lanplus -U admin -P admin sol set volatile-bit-rate 115.2

echo "verify bios:"
ipmitool -H "$host" -I lanplus -U admin -P admin sol activate
