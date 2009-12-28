#!/bin/sh
set -e
set -x
iwconfig wlan0 essid MOBILE
sleep 2
udhcpc -nfqi wlan0
vpnc ~nico/ethz/vpn/pc
