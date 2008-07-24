#!/bin/sh
# Nico Schottelius, 20080514

hosts="62.65.130.180 62.65.130.181"
opts="-p 6543 -U postgres"
tmpdir="$(mktemp -d /tmp/iuaeiueve.XXXXXXXXXXXXXXXX)"


lasthost=""
for host in $hosts; do
   psql $opts -h "$host" -l | \
      awk 'BEGIN { getline; getline } $2 ~ /\|/  { print $1 }' \
         > "$tmpdir/db.$host"

   if [ "$lasthost" ]; then
      echo "Comparing DBs from $lasthost and $host"
      diff -u  "$tmpdir/db.$lasthost" "$tmpdir/db.$host"
   fi
   lasthost="$host"
done

for db in $(cat "$tmpdir/db.$lasthost"); do
   echo "Comparing Database $db ..."
   
   echo '\d' | psql $opts -h "$lasthost" "$db" | \
      awk '$5 ~ /table/ { print $3 }' > "$tmpdir/tables.$lasthost"

   while read table; do
      echo -n "Comparing Table $table ($db) ..."
         lastcount=""
         lasthost=""
         allcount=""
         for host in $hosts; do
            count="$(echo "select count(*) from $table" | \
               psql $opts -h "$host" "$db" | \
                  awk 'BEGIN { getline; getline } { print $0; exit 0 }')"
            allcount="$allcount $count"
            if [ "$lastcount" ]; then
               if [ "$lastcount" -ne "$count" ]; then
                  echo "mismatch: $lasthost \($lastcount\) != $host \($count\)"
               fi
            fi
            lasthost="$host"
         done
      echo "$allcount"
   done < "$tmpdir/tables.$lasthost"


done

rm -rf "$tmpdir"
