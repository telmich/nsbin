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

channel="1"
sleep="5"

modprobe ipmi_si
modprobe ipmi_devintf
ipmitool lan set $channel ipsrc static
sleep $sleep
ipmitool lan set $channel ipsrc bios
sleep $sleep
ipmitool lan print $channel
sleep $sleep
ipmitool lan set $channel ipsrc dhcp
sleep $sleep
ipmitool lan print $channel
