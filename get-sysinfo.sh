#!/bin/sh
# 
# 2008 - 2010 Nico Schottelius (nico-nsbin at schottelius.org)
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
# Retrieve system information including this script
#


host="$(hostname)"
dest="${0%%*/}.${host}.log"

(
   # log, what produced the output
   cat "$0"

   uname -a
   dmesg

   # pci stuff
   lspci -nn
   lspci -vv

   # hw in total
   lshw

   # ram
   free

   # cpu
   cat /proc/cpuinfo

   # disk
   mount
   df -h

) 2>&1 | tee "${dest}"
