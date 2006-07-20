HOSTS="www.spiegel.de www.lernen.de www.isc.org B.ROOT-SERVERS.NET"

STATUS=offline

for myh in $HOSTS; do
   ping -c1 $myh >/dev/null 2>&1 && STATUS=online
done

if [ "$STATUS" = offline ]; then
   echo 'Offline.'`date`
fi
