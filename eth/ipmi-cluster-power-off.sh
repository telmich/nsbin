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
# Usage: $0 username password clusterprefix number-of-nodes
#


# user/pass for ipmi
user="$1"; shift
pass="$1"; shift
cluster="$1"; shift
count="$1"; shift

for i in $(seq 1 16); do
   num=$(printf "%0.2d" $i) 
   echo Trying $cluster/${num}:
   ipmitool -U "$user" -P "$pass" -I lanplus -H ${cluster}${num}-ra power off
   ipmitool -U "$user" -P "$pass" -I lanplus -H ${cluster}${num}-ra power status
done
