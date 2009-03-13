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
#

################################################################################
# standard vars
# Stolen from cconf
__pwd="$(pwd -P)"
__mydir="${0%/*}"; __abs_mydir="$(cd "$__mydir" && pwd -P)"
__myname=${0##*/}; __abs_myname="$__abs_mydir/$__myname"

usage()
{
   echo "Usage: ${__myname} <destination directory> [optional prefix]"
   echo "Must be run in linux tree cloned with git."
   exit 1
}

if [ $# -lt 1 ]; then
   usage
fi

dir="$1"; shift
prefix="$1"
version=$(git describe)
source=".config"

if [ ! -d "$dir" -o -z "$version" -o ! -f "$source" ]; then
   usage
fi

cp -v "$source" "$dir/${prefix}${version}"
