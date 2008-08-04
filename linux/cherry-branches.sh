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

echo "Displaying commits you don't have in your tree"

for remote in $(git-branch -r); do
   #echo "==> Cherry: $remote ..."
   # is slow
   # git-cherry $remote | grep -v '^+ '

   # is fast
   git-log --pretty=oneline --left-right master..$remote | sed "s;^;$remote;"
done
