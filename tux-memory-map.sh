#!/bin/sh

pid=$$

file=/proc/$pid/maps

awk '
      function todec(str)
      {
         hstr = "1234567890abdcef";
         res  = 0;
         n    = split(str, digit, "");

         for(i=1; i<=n; i++) {
            num = index(hstr, digit[i])-1;
            res = res + (num*16^(n-i));
         }
         return res;
      }
      # hex numbers are big, do subtract of small numbers!
      function hexsub(a, b)
      {
         hstr = "0123456789abdcef";
         an = split(a, aa, "");
         bn = split(b, ba, "");

         max = an > bn ? an : bn;
         i = 1;
         res = 0;

         while(i <= max) {
            if(an < i) aa[i] = 0;
            else if(bn < i) ba[i] = 0;

            da = index(hstr, aa[i]) -1;
            db = index(hstr, ba[i]) -1;

            diff = (da - db) * 16^i;
            res = res + diff;
         }
      }

   {
      memory=$1;
      file=$6;
      ele = split(memory, memreg, "-");
      start =memreg[1];
      end  = memreg[2];
      start_dec = todec(start);
      end_dec   = todec(end);
      len  = end_dec - start_dec;

      print len "\t" start_dec " " end_dec " "  memory ": " file
   }
   ' < "$file"
   #' < "$file" | sort -g
