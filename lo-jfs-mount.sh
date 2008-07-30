#!/bin/sh

hier=$(dirname $0)
hierabs=$(cd "$hier" && pwd -P)

sudo losetup -o 32256 /dev/loop0 "$hierabs/debian-hd.img"
sudo fsck.jfs /dev/loop0
sudo mount /dev/loop0 $(dirname $0)/dst
