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
# Usage: $0
#

file=~/ethz/lp-0042-stats
date="$(date +%s)"
f="$file/$date"

set -e

[ "$1" = dry ] || \
   snmpget  -c public -v1 -Ov lp-0042.ethz.ch mib-2.43.10.2.1.4.1.1 | \
      sed 's/.*: //' | \
         tee "$f"

cd "${file}"

last=0;
flast=0;

first_time=""
first_pages=""
last_time=""
last_pages=""

echo '$file: $new - $diff - $fdiff - $mdiff - $pages_per_hour - $pages_per_minute - $pages_month'

for file in *; do
   new=$(cat "$file");
   diff=$(($new - $last));
   fdiff=$((file - flast));
   mdiff=$((fdiff / 60));
   hdiff=$((fdiff / 3600));

   [ "$first_time" ] || first_time="$file"
   [ "$first_pages" ] || first_pages="$new"

   if [ "$mdiff" -gt 0 ]; then
      pages_per_minute=$(($diff / $mdiff));
   else 
      pages_per_minute=-1
   fi
   if [ "$hdiff" -gt 0 ]; then
      pages_per_hour=$(($diff / $hdiff));
   else 
      pages_per_hour=-1
   fi
   last="$new";
   flast="$file";

   pages_month=$((pages_per_hour * 24 * 30))
   echo $file: $new - $diff - $fdiff - $mdiff - $pages_per_hour - $pages_per_minute - $pages_month
done

last_time="$file"
last_pages="$new"

diff_time="$((last_time - first_time))"
diff_time_h="$((diff_time / 3600))"
diff_time_d="$((diff_time_h / 24))"
diff_pages="$((last_pages - first_pages))"


echo "Overall: ${diff_time}s (${diff_time_h}h) (${diff_time_d}d): - ${diff_pages}: $((3600 * 24 * 30 * diff_pages/diff_time)) / month"

