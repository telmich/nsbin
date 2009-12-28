#!/bin/sh

ip l s eth0 down
ip l s wlan0 up 
iwconfig wlan0 essid hotspot-hsz-t
udhcpc -nfqi wlan0

