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
# If you've many linux-X.Y.Z directiories and want to save the config
# and remove all the old sources, this script is what you searched for.
#

# Linux is configured via .config
srcfile=".config"

# This is where we save the configs
dstdir='configs'

mkdir -p "$dst"

for conf in */.config; do
   mv "$conf" "$dstdir/${conf%%/*}"
   rem="${conf%%.config}"
   echo "Removing $rem in background..."
   rm -rf ${conf%%.config} &
done

echo "Waiting for removal of sources..."
wait
