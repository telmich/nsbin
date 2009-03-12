#!/bin/sh
# Nico Schottelius
# Script to test if iwlagn wlan associated or not after suspend
# run in screen, started via ssh

while true; do echo mem > /sys/power/state ; dmesg; iwconfig wlan0 essid public; sleep 5; iwconfig wlan0; sleep 5; echo =========; iwconfig wlan0 essid public; sleep 5; iwconfig wlan0; read test ; done

