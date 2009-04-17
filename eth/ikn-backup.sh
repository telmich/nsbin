#!/bin/sh -e


ccollect=/home/user/nico/p/ccollect/ccollect/ccollect.sh

# in pre_exec
#cryptsetup luksOpen /dev/sdc usbhd
#mount /home/services/usbhd 

#cd /home/user/nico/p/ccollect/ccollect
CCOLLECT_CONF=/home/users/nico/ethz/ccollect $ccollect wöchentlich ikn

# in post_exec
#umount /home/services/usbhd 
#cryptsetup luksClose usbhd

