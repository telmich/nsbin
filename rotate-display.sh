#!/bin/sh

mode_path=/sys/devices/platform/thinkpad_acpi/hotkey_tablet_mode

# 0 = normal
# 1 = tablet
mode=$(cat $mode_path)

if [ $mode = 1 ]; then
	mode=inverted
else
	mode=normal
fi

current=$(xrandr | awk '/LVDS1/ { print $4 }' | sed 's/(//')

# Do not change anything if already ok
[ $current = $mode ] && exit 0

if [ "$mode" = inverted ]; then
	xinput --set-prop 'Serial Wacom Tablet WACf004 stylus' 'Wacom Rotation' 3
	xrandr  --output LVDS1  --rotate inverted
else
	xinput --set-prop 'Serial Wacom Tablet WACf004 stylus' 'Wacom Rotation' 0
	xrandr  --output LVDS1  --rotate normal
fi
	
