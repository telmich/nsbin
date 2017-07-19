#!/bin/sh
# Nico Schottelius
# 2007-02-04
# Install a product to listed instances, change permissions
# Nothing spectacular, but useful

instances="/home/server/zope/instance/nico.schottelius.org.1 \
           /home/server/zope/instance/nico.schottelius.org.2"

zope_user="zope"

######################## NO CHANGES BELOW HERE NEEDED ##########################

if [ $# -ne 1 ]; then
   echo "$0: product (tar, gzipped)"
   exit 23
fi

product="$1"
echo "Installing $product ..."
echo ""

# do NOT continue on failure!
set -e
for instance in $instances; do
   proddir="${instance}/Products"
   echo "Extracting product to $instance ..."
   tar xfz "$product" -C "$proddir"
   echo "Changing owner to $zope_user (for all products) ..."
   chown -R "$zope_user" "$proddir"
done

echo ""
echo "Restart your zope server(s) now (if not running in debug mode)"
