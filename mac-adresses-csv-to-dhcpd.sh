#!/bin/sh

sep=';'
name='dryad'
hostname="$1"; shift
ipnbase="$1"; shift
field="$1"; shift
file="$1"; shift

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
      mac = mac2dp($field);
      print \
         "      host " hostname hc " {\n" \
         "         hardware ethernet " mac ";\n" \
         "         fixed-address " ipnbase hc ";\n" \
         "      }";
      hc++;
   }' ipnbase="$ipnbase" field="$field" hostname="$hostname" < "$file" 
