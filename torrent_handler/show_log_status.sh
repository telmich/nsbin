for file in logs/*;
   do
   echo -n "${file}: ";
   tail -n20 "$file" | grep "percent done:" | tail -n1;
done
