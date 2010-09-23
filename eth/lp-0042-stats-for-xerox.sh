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

xerox_hostname=lp-0042.ethz.ch

# Mail from Steven Armstrong:
#Page Count
#--------------------------------------------------------------------------------
#snmpget -c public -v1 $xerox_hostname 1.3.6.1.2.1.43.10.2.1.4.1.1
#SNMPv2-SMI::mib-2.43.10.2.1.4.1.1 = Counter32: 30745
#--------------------------------------------------------------------------------
#
#Total Impressions
#--------------------------------------------------------------------------------
#snmpget -c public -v1 $xerox_hostname 1.3.6.1.2.1.43.10.2.1.4.1.1
#SNMPv2-SMI::mib-2.43.10.2.1.4.1.1 = Counter32: 30734
#--------------------------------------------------------------------------------
# 
#Black Impressions
#--------------------------------------------------------------------------------
echo "B&W:"
snmpget -c public -v1 $xerox_hostname 1.3.6.1.4.1.253.8.53.13.2.1.6.1.20.34
#SNMPv2-SMI::enterprises.253.8.53.13.2.1.6.1.20.34 = INTEGER: 19735
#
#--------------------------------------------------------------------------------
#Black Copied Impressions
#--------------------------------------------------------------------------------
#snmpget -c public -v1 $xerox_hostname
#1.3.6.1.4.1.253.8.53.13.2.1.6.103.20.3
#SNMPv2-SMI::enterprises.253.8.53.13.2.1.6.103.20.3 = INTEGER: 3002
#
#--------------------------------------------------------------------------------
#Black Printed Impressions
#--------------------------------------------------------------------------------
#snmpget -c public -v1 $xerox_hostname
#1.3.6.1.4.1.253.8.53.13.2.1.6.1.20.7
#SNMPv2-SMI::enterprises.253.8.53.13.2.1.6.1.20.7 = INTEGER: 16733
#
#--------------------------------------------------------------------------------
#Color Impressions
#--------------------------------------------------------------------------------
echo "Colour:"
snmpget -c public -v1 $xerox_hostname 1.3.6.1.4.1.253.8.53.13.2.1.6.1.20.33
#SNMPv2-SMI::enterprises.253.8.53.13.2.1.6.1.20.33 = INTEGER: 10999
#
#--------------------------------------------------------------------------------
#Color Copied Impressions
#--------------------------------------------------------------------------------
#snmpget -c public -v1 $xerox_hostname
#1.3.6.1.4.1.253.8.53.13.2.1.6.103.20.25
#SNMPv2-SMI::enterprises.253.8.53.13.2.1.6.103.20.25 = INTEGER: 727
#
#--------------------------------------------------------------------------------
#Color Printed Impressions
#--------------------------------------------------------------------------------
#snmpget -c public -v1 $xerox_hostname
#1.3.6.1.4.1.253.8.53.13.2.1.6.1.20.29
#SNMPv2-SMI::enterprises.253.8.53.13.2.1.6.1.20.29 = INTEGER: 10272

