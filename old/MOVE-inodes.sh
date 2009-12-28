for a in `seq 1 9`; do
   for b in `seq 1 9`; do
      for c in `seq 1 9`; do
         for d in `seq 1 9`; do
            for e in `seq 1 9`; do
               for f in `seq 1 9`; do
                  mkdir -p $a/$b/$c/$d/$e/$f
                  mv -f \$Inode$a$b$c$d$e$f* $a/$b/$c/$d/$e/$f 2>/dev/null
               done
            done
         done
      done
   done
done
