# small script, which helps to make mutt alias from netscape alias
# Author: Nico Schottelius <nico@schottelius.org>
# Date: 12th of March 2002
# Last Changed: same
#

# alias name1 name2 name3 <emailaddr> to
# alias name1name2name3 name1 name2 name3 <emailaddr>

/^alias .* <.*>$/ {
   save=ORS
   ORS=""
   line++;
   print "alias "
   for(j=2;j<NF;j++)
      print $j
   for(i=2;i<=NF;i++)
      print " " $i
   ORS=save
   print ""
}
