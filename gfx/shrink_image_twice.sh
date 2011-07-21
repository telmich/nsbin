#!/bin/sh
# 
# 2007      Nico Schottelius (nico-nsbin at schottelius.org)
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
# Shrink images and output two different sizes: 50% and 25% size
#


bild="$1"
bild_neu="${bild%.jpeg}.png"
bild_neu_klein="${bild%.jpeg}-small.png"

convert "$bild" -resize 50% "$bild_neu"
convert "$bild_neu" -resize 50% "$bild_neu_klein"
