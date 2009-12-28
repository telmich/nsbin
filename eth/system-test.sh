#!/bin/sh

# 1. collect information about the system:
# - cpu
# - memory
# - lshw
# - dmesg
# -
# 2. test memory
# 2. test harddrive
# - raid?
# - performance
# test reboots
#
# 

cores="$1"; shift
scratch="$1"; shift
mem="$1"; shift

# 7d
cpuburn

# 7d
stress -i "$cores"

# 64 samples
wget http://www.coker.com.au/bonnie++/bonnie++-1.03d.tgz
tar xfvz bonnie++-1.03d.tgz 
cd bonnie++-1.03d
./configure && make 
cd $scratch

bonnie++ -d . -s 36g -n 256 -n 64 -u 0 | tee /root/bonnie-mnt

# 
iozone -A

# 24h
reboot

# netperf
