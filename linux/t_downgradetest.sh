#!/bin/sh -e
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

# Idea:
#
# Test different official kernels, begin with latest, skip rcs
#
parallel="-j32"

#
# Standard variables (stolen from cconf)
#
__pwd="$(pwd -P)"
__mydir="${0%/*}"; __abs_mydir="$(cd "$__mydir" && pwd -P)"
__myname=${0##*/}; __abs_myname="$__abs_mydir/$__myname"


marker="${__pwd}/.${__myname}.marker"

if [ -f "$marker" ]; then
   oldversion="$(cat $marker)"
   version="$(git tag | grep -B 1 "$oldversion" | head -n1)"
else
   version="$(git tag | tail -n1)"
fi

novversion=$(echo $version | sed 's/^v//')

echo "Building $version"
echo "$version" > "$marker"

git checkout -b "${__myname}-${version}" ${version}

# build kernel
make $parallel clean
cat /boot/config-2.6.26-2-amd64 >> .config
yes "" | make $parallel oldconfig
make $parallel all

# install kernel
make $parallel install modules_install

# create initramfs
update-initramfs -c -k "$novversion"

# copy images
cp "arch/x86/boot/bzImage" "/boot/vmlinuz-${__myname}"
cp "/boot/initrd.img-${novversion}" "/boot/initrd-${__myname}"

# reboot
#reboot
