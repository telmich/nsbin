
#devs='/dev/sde /dev/sdf /dev/sdg'
devs="/dev/sdb /dev/sdc /dev/sdd"
set -e
set -x
mdadm --assemble /dev/md0 $devs
cryptsetup luksOpen /dev/md0 raid
fsck /dev/mapper/raid
mount /home/server/raid

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

