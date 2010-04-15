#!/bin/sh
# Nico Schottelius, 2010
# Copying: GPLv3
#
# Add the following line to your .netrc:
#  machine wiki.systems.ethz.ch login YOURLOGNIN password YOURPASSWORD
#

site='https://wiki.systems.ethz.ch/systems_utilisation?action=raw'

export year="$(date +%Y)"
export month="$(date +%m)"
export day="$(date +%d)"

# 
# get reservations
# get current date
# do not change reservations that
# 
#  a) are permanent
#  b) end in the future
#  c) are empty
# 
# for all other reservations: delete
# 
   #sed 's/||/|/g'    | \
   #sed 's/|/||/g'

curl --silent --netrc ${site} | \
   awk 'BEGIN { FS="||" } 
      { print "- " $1 "--" }

      $4 !~ /(permanent|time-frame|^ *$)/ { 

      orig = $0

      # Dateformat: YYYY-MM-DD - YYYY-MM-DD
      # Remove beginning date
      sub(/....-..-.. - /, "", $4)
      split($4, enddate, "-")
      year = enddate[1]
      month = enddate[2]
      day = enddate[3]

      cyear = ENVIRON["year"]
      cmonth = ENVIRON["month"]
      cday = ENVIRON["day"]

      if(year >= cyear && month >= cmonth && day >= cday) {
         print orig
      } else {
         print "|| " $2 " || || || || BOOKABLE ||"
      }

      print $2 ":" year cyear " " month " " day
   }
      # print unchangable lines
      $4 ~ /(permanent|time-frame|^ *$)/ { print $0 }
   '

