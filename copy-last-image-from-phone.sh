#!/bin/sh
# 
# 2015      Nico Schottelius (nico-nsbin at schottelius.org)
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
# Copy the last taken image from my Android phone
# 


user=root
host=192.168.43.1
port=2222
path=/storage/sdcard0/DCIM/Camera

scp -P $port $user@$host:$path/$(ssh -p $port $user@$host "ls -1tr $path | tail -n1") .
