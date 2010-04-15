#!/bin/sh -e


#if [ -z "$USBHD" -o $# -ne 1 ]; then
#   echo USBHD + interval
#   exit 1
#fi

ccollect=/home/users/nico/oeffentlich/rechner/projekte/ccollect/ccollect/ccollect.sh

# in pre_exec
#cryptsetup luksOpen /dev/sdc usbhd
#mount /home/services/usbhd 

#cd /home/user/nico/p/ccollect/ccollect
export CCOLLECT_CONF=/home/users/nico/ethz/ccollect
$ccollect $1 ikn$2

# in post_exec
#umount /home/services/usbhd 
#cryptsetup luksClose usbhd

