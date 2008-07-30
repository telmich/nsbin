#!/bin/sh

hier=$(dirname $0)
hierabs=$(cd "$hier" && pwd -P)

sudo umount $(dirname $0)/dst
sudo losetup -d /dev/loop0 
