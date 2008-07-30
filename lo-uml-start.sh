#!/bin/sh

hier=$(dirname $0)
hierabs=$(cd "$hier" && pwd -P)

sudo losetup -o 32256 /dev/loop0 "$hierabs/debian-hd.img"
linux ubd0=/dev/loop0 init=/sbin/cinit "$@"
sudo losetup -d /dev/loop0 

