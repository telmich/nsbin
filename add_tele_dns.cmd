if [ $# -ne 2 ]; then
	echo noe. $0 name telefon
	exit 1
fi

FORWARD=/etc/bind/tele.wdt.intern.hosts
REVERSE=/etc/bind/10.10.1.rev

read -p "Name: " name
read -p "Telefonnummer: " tele
read -p "Eintragen (strg+c zum abbrechen) "

if [ "$tele" -le 255 ]; then
	echo "$name		in A		10.10.1.$tele" >> $FORWARD
	echo "$tele		in ptr		$name.tele.wdt.intern." >> $REVERSE
else
	echo "$name bekommt keinen A eintrag, da zu grosse nummer"
fi

echo "$name		in TXT		\"$tele\"" >> $FORWARD

killall -HUP named
