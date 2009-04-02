#!/bin/sh -e
# Nico Schottelius, 20080910 11:09
#ip link set wlan0 down
#iwconfig wlan0 essid public
#ip link set wlan0 up
#iwconfig wlan0 essid public

set -x

ip l s eth0 down
( wpa_cli terminate; exit 0 )
rmmod iwlagn
modprobe iwlagn
sleep 2
wpa_supplicant -B -Dwext -iwlan0 -c ~nico/ethz/wlan/wpa_supplicant.conf
sleep 5
udhcpc -nqfi wlan0
vpnc ~nico/ethz/vpn/pc.conf

#vpnc ~nico/firmen/ethz/vpn/vpnc.conf
# vpnc-disconnect
