#!/bin/sh -e
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

set -e
#version="$(git describe)
version=$(cat include/config/kernel.release)
ddir="/boot"
spath="arch/x86/boot/bzImage"
fname="vmlinuz-$version"
fpath="${ddir}/${fname}"
gpath="$ddir/grub/menu.lst"


#make install
cp "$spath" "$fpath"
make modules_install
#update-grub
cat << eof >> "$gpath"
title  $version
root   (hd0,0)
kernel ${fpath}

eof

echo "Reboot should reboot to $version now ..."
read notyet
reboot
