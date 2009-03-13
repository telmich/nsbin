#!/bin/sh
# 
# 2008      Nico Schottelius (nico-linux-next at schottelius.org)
# 
# This file is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This file is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this file. If not, see <http://www.gnu.org/licenses/>.
#
#
# This script initialises all the git remotes found in the next-tree,
# so you can merge them yourself.
#
# You've to run it in a linux-next cloned directory:
#
#  % git clone git://git.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git
#  % cd linux-next
#  % next-init-branches.sh
# 
#

for remote in $(awk '$2 ~ /git/ { print $1 }' Next/Trees); do
   url=$(awk "\$1 ~ /$remote/ { print \$3 }" Next/Trees)
   rurl=$(echo $url | awk -F'#' '{ print $1 }')
   branch=$(echo $url | awk -F'#' '{ print $2 }')

   # reset, if it changed or we ran before
   git-remote rm $remote 2>/dev/null
   git-remote -v add $remote -t $branch $rurl
done
