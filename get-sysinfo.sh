#!/bin/sh

host="$(hostname)"
dest="${0%%*/}.${host}.log"

(
   # system / software
   uname -a
   dmesg

   # pci stuff
   lspci -nn
   lspci -vv

   # hw in total
   lshw

   # ram
   free

   # cpu
   cat /proc/cpuinfo

   # disk
   mount
   df -h

) 2>&1 | tee "$dest"
