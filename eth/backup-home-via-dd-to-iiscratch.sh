#!/bin/sh -e

bs=32k
nice=20

base=/auto/iiscratch/nicosc/
old=$base/ikn
new=$base/ikn2

date
time nice -n $nice dd if=/dev/sda3 of=$new bs=$bs
mv $new $old
date
