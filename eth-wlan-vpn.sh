#!/bin/sh -e
# Nico Schottelius, 20080910 11:09
ip link set wlan0 down
iwconfig wlan0 essid public
ip link set wlan0 up
iwconfig wlan0 essid public
udhcpc -nqfi wlan0
vpnc ~nico/firmen/ethz/vpn/vpnc.conf
