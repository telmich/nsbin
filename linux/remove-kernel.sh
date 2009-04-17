#!/bin/sh -e
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
# Remove a kernel:
#  /boot/
#     System.map-$version
#     vmlinuz-2.6.28-rc9-wl-denkbrett-24896-gf4f5c96
# /lib/modules/2.6.2...
#
#

while [ "$#" -ge 1 ]; do
   version="$1"; shift

   rm -vrf "/boot/System.map-$version" "/boot/vmlinuz-$version" "/lib/modules/$version"

   echo "Warning: Keeping configuration (/boot/config-$version)."

done
