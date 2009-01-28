#!/bin/sh

file="$1"
sep=';'
name='dryad'

awk "-F$sep" 'BEGIN {
      hc=1;
   }

   function mac2dp(mac)
   {
      i=0;
      newmac=""
      while (i < 5) {
         newmac = sprintf("%s%s:",newmac,substr(mac,(1+i*2),2));
         i++;
      }
      newmac = sprintf("%s%s",newmac,substr(mac,(1+i*2),2));
      return newmac;
   }

   
   /^S-09/
   {
      mac = mac2dp($2)
      print "      host dryad" hc \
         " {\n         hardware ethernet " mac
            ";\n         fixed-address 192.168.54."
            i
            ";\n      }";
      hc++;
   }' < "$1"
