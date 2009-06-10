#!/bin/sh

dest="${0%%*/}.log"

(
   uname -a
   dmesg
   lspci -nn
   lspci -vv
   lshw
   free
   cat /proc/cpuinfo

) 2>&1 | tee "$dest"
