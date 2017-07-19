#!/bin/sh

[ "$#" -eq 2 ] || exit 1

user="$1"
domain="$2"
password="$3"

base=/home/server/mail

maildirmake.dovecot 

cat << eof
insert into mailboxes values ('$user','$domain','$password','$domain/$user',1,1)
eof | psql mail

