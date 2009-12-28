#!/bin/sh

out=bonnie.html
hosts="root@sgss5520ur01:/root/bonnie-mnt3 root@sgsr61001:/root/bonnie-local2"
tmp=$(mktemp -d /tmp/anyhow.XXXXXXXXXXXXX)

for host in $hosts; do
   scp $host $tmp
done

cat $tmp/* | bon_csv2html > $out

echo rm -rf "$tmp"
