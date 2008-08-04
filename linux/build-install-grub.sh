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

# comment out on single cpu systems
parallel="-j8"

(
   set -e
   set -x

   # clean
   make $parallel clean
   
   # create config - use the last one, as far as possible
   make oldconfig

   # build
   make $parallel all

   # install
   sudo make install
   sudo make modules_install

   # script to regenerate grub.cfg (grub2)
   sudo update-grub

   version=$(cat include/config/kernel.release)

   echo "Reboot should reboot to $version now ..."
)
