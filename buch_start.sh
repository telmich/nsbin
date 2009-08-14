
dev1="/dev/sd$1"; shift
dev2="/dev/sd$1"; shift
dev3="/dev/sd$1"; shift

#devs='/dev/sde /dev/sdf /dev/sdg'
devs="/dev/sde /dev/sdc /dev/sdd"
set -e
set -x
mdadm --assemble /dev/md0 $dev1 $dev2 $dev3
cryptsetup luksOpen /dev/md0 raid
fsck /dev/mapper/raid
mount /home/services/raid

exit 0

#mdadm --assemble /dev/md0 /dev/sde /dev/sdf /dev/sdg
#cryptsetup luksOpen /dev/md0 raid

[19:25] denkbrett:~nico#          mdadm --assemble --scan             
/dev/md0: File exists
mdadm: /dev/md/0 has been started with 2 drives (out of 3).
mdadm: /dev/md/0 already active, cannot restart it!
mdadm:   /dev/md/0 needed for /dev/sdc...
mdadm: /dev/md/0 already active, cannot restart it!
mdadm:   /dev/md/0 needed for /dev/sdc...
[19:25] denkbrett:~nico# mdadm --manage -a /dev/md0 /dev/sdc 
mdadm: re-added /dev/sdc
[19:25] denkbrett:~nico# 

