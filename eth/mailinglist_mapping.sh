#!/bin/sh

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
