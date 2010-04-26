#!/bin/sh
# 
# 2010      Nico Schottelius (nico-nsbin at schottelius.org)
# 
# This file is part of nsbin.
#
# nsbin is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# nsbin is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with nsbin. If not, see <http://www.gnu.org/licenses/>.
#
#
# Usage: $0 (outputs mapping)
#


prof_0="donaldk"
prof_1="alonso"
prof_2="tatbuln"
prof_3="roscoe"

ml_0="dbis"
ml_1="iks"
ml_2="adms"
ml_3="netos"

classes="staff stud guest"
extraclasses="other"
allclasses="$classes $extraclasses"
allprofs=""

i=0
while [ $i -lt 4 ]; do
   eval prof=\$prof_$i
   eval ml=\$ml_$i
   allprofs="$prof $allprofs"

   for class in $classes; do
      echo "# Create (automatic) mailinglist: ${ml}-${class}"
      echo ou_tool -x mailing_list=${ml}-${class} --modify $class@$prof
   done
   echo "# Create extra (manual) mailinglist: ${ml}-other"
   echo "# Create extra (umbrella) mailinglist (containing $allclasses): ${ml}-all"
   i=$(($i+1))
done

for class in $allclasses; do
   echo "# Create umbrella list systems-$class containing {${allprofs}}-$class"
done
echo "# Create umbrella list systems-all containing {systems-{$allclasses}"
