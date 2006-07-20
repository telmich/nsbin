#!/bin/sh

URL=http://www.schaustdu.de/ba/

# test1
# curl http://www.schaustdu.de/ba/ | grep -i -e 'value=' -e 'href=' | sed s'/.*"\(.*\)".*/\1/' | grep -v saugen

# test2
# curl http://www.schaustdu.de/ba/ | grep -i -e 'value=' -e 'href=' | sed -e 's/"//g' -e 's/value=/href=/g' | sed 's/.*href=\(.*\)>.*/\1/' | sed 's/>.*//' |  grep -v saugen

# test3 - final

DOCS=`curl http://www.schaustdu.de/ba/ | grep -i -e 'value=' -e 'href=' | sed -e 's/"//g' -e 's/value=/href=/g' | sed 's/.*href=\(.*\)>.*/\1/' | sed 's/>.*//' |  grep -v -e saugen -e http -e mailto:`

# go get them!
for doc in $DOCS; do
   wget -c ${URL}${doc}
done
