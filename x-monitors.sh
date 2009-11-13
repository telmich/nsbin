#!/bin/sh
# 
# 2009      Nico Schottelius (nico-nsbin at schottelius.org)
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
# Automatically manage connected and disconnected external monitors with xrandr
#
# Add your main monitor to ~/.x-monitors-main (i.e. the laptop screen),
# and add all possible other monitors in the positions files
# ~/.x-monitors-{left-of right-of above below}.
#
#
# 

################################################################################
main="$(cat ~/.x-monitors-main)"
positions="left-of right-of above below"
prefix=".x-monitors-"

i=0

# Needs to run twice: xrandr may not be able to
# enable a newly connected monitor, because a disconnected one
# is still enabled. The first runs disables disconnected monitors, the
# second one enables all connected ones.
while [ "${i}" -lt 2 ]; do
   # search for all possible monitors in all positions
   for position in $positions; do
      posfile="${HOME}/${prefix}${position}"
      if [ -f "${posfile}" ]; then
         while read output; do
            xrandr --output "${output}" --${position} "${main}" --auto
         done < "${posfile}"
      fi
   done

   i=$(($i+1))
done
