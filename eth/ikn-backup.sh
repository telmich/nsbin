#!/bin/sh -e

cryptsetup luksOpen /dev/sdc usbhd
mount /home/services/usbhd 

cd /home/user/nico/p/ccollect/ccollect
CCOLLECT_CONF=/home/services/usbhd/ccollect ./ccollect.sh wöchentlich ikn

umount /home/services/usbhd 
cryptsetup luksClose usbhd

