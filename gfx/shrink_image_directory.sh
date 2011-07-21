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
# Shrink all images in a directory twice and store them in a subdir
#


dir="$1"
newdir="${dir}/kleiner"

set -e

mkdir -p "$newdir"

for bild in "$dir"/*.jpg; do
   bild_base=$(basename "$bild")
   bild_neu="${newdir}/${bild_base%.jpeg}.png"
   bild_neu_klein=${bild_neu%.png}-small.png
   bild_neu_kleinjpg=${bild_neu%.png}-small.jpg
   echo "Convert $bild"
   convert "$bild" -resize 50% "$bild_neu"
   convert "$bild_neu" -resize 50% "$bild_neu_klein"
   convert "$bild_neu" -resize 50% "$bild_neu_kleinjpg"
done
