#!/bin/sh
# Use the lan instead of the wlan

wpa_cli terminate
killall vpnc
ip l s wlan0 down
ip l s eth0 up   
