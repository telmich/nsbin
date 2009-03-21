#!/bin/sh

udhcpc -nfqi wlan0 &&  vpnc ~nico/ethz/vpn/pc.conf

