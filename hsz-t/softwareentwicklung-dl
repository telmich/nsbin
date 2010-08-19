#!/bin/sh
# 
# 2010 Nico Schottelius (nico-nsbin at schottelius.org)
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
# Prepare exam
#

set -e

d="static.edu.panter.ch"
f="${d}.tar.bz2"
p="PruefungsStoff2010.html"
bd="swdev"
b="firefox"
v="evince"

mkdir ${bd}
wget "http://static.edu.panter.ch/offline/$f"
wget http://pubwww.hsz-t.ch/~bseelige/info2/pattern/DesignJava.PDF
wget http://pubwww.hsz-t.ch/~bseelige/info2/uml/uml2.pdf

tar xvfj ${f}

"$b" "$d/$p" &
"$v" DesignJava.PDF &
"$v" uml2.pdf &
