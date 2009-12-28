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
# Fetches all remotes and merges tracked trees
#
# Idea is to track only interesting remote branches (see linux/likenext-init.sh)
#

failed=""

# update first, so we can continue to work if we go offline later
for remote in $(git remote); do
   git fetch -v "$remote"
done

# merge
for rbranch in $(git branch -r); do
   if ! git merge "$rbranch"; then
      failed="$failed $rbranch"
      git reset --hard
   fi
done

if [ "$failed" ]; then
   echo "Failed merges: $failed"
   exit 1
fi

