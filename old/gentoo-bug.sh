#!/bin/sh
# generate gentoo bug-report          
# Nico Schottelius <nico-linux-gentoo ... schottelius.org
# gentoo-bug.sh
# 

REPORTER="Nico Schottelius <nico-linux-gentoo ... schottelius.org>"

umask 077
TMP_BASE=/tmp/`basename $0`-${USER}
TMP=${TMP_BASE}-$$

# read input
reread()
{
   _tmp=""
   name="$1"

   while [ ! "$_tmp" ]; do
      read -p "$1 [$_tmp]: " _tmp
	done

   echo $_tmp
}

echo "This makes a small bugreport suitable for developers of the gentoo system."
echo "----------------"
echo "Please enter information as exact as possible. Thanks."
echo ""

package=`reread package-name`
error=`reread "Error occurred (short description)"`
problem=`reread "Please describe problem in your words"`

rm -f "$TMP"
# make a good filename 
TMP=${TMP_BASE}-${package}

# generate file
#cat << EOF
cat << EOF > "$TMP"
--------------------
Bug-Reporter for gentoo - http://linux.schottelius.org/scripts/#gentoo-bug.sh
--------------------
package: $package
--------------------
reporter: $REPORTER
--------------------
error: $error
--------------------
problem-description: $problem
--------------------
uname-a: `uname -a`
--------------------
make.conf: `grep -v '^#' /etc/make.conf | grep -v '^$'`
--------------------
emerge-info: `emerge --info`
--------------------
other-info:
EOF

echo "If you have additional information, please add them to the report."
echo "Now, please mail the resulting file to a gentoo-maintainer/developer:"
echo "$TMP"
