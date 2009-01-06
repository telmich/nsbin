file=wordlist


while true; do 
   while read satz; do
      echo "$satz" | osd_cat -p middle -A center -f '-misc-fixed-medium-r-semicondensed--*-542-*-*-c-*-*-*' -d 1
      sleep 5
   done < "$file"
done
