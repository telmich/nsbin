#!/bin/sh
# Reboot the entire cluster & send mail to me
dsh -g dryad -c "(uptime; dmesg) | mail -s \"\$(hostname) down at \$(date)\" nicosc@inf.ethz.ch && reboot"
