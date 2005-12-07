#!/bin/sh
# Nico Schottelius
# Date: Mit Nov  9 12:57:04 CET 2005
# Last Modified: Thu Nov 10 12:53:00 CET 2005
# 
# Install latest git and cogito to $INSTALL_PREFIX/$name and
# link the binaries to $BINDIR
# Needs git and cogito to work!
# And:
# - libexpat-dev
# - libcurl3-dev
# - libssl-dev
# - libz-dev

BASE_GET=http://www.kernel.org/pub/scm/
PROJECTS="git/git.git cogito/cogito.git"
BUILDDIR=/home/user/nico/build
INSTALL_PREFIX=/usr/packages
BINDIR=/usr/local/bin

error_in()
{
   echo "[failed] $1"
   echo "Exiting now."
   exit 1
}

for project in $PROJECTS; do
   realname=$(echo $project | sed -e 's,.*/,,' -e 's/\.git$//')

   echo "Working on $realname (in $BUILDDIR/$realname) ... "

   if [ ! -d "$BUILDDIR/$realname" ]; then
      echo "Cloning $realname"
      cg-clone "${BASE_GET}${project}" "$BUILDDIR/$realname"
   else
      echo "Updating $realname from \"origin\""
      cd "$BUILDDIR/$realname" || error_in "$BUILDDIR/$realname"
      cg-update origin
   fi

   if [ $? -ne 0 ]; then
      echo "Pull or clone failed, aborting now."
      exit 23
   fi

   cd "$BUILDDIR/$realname"
   version=$(cg-object-id)
   echo "Installing $realname (Version: $version)"
   DDIR=$INSTALL_PREFIX/$realname-$version
   make clean || error_in "Cleaning $realname"
   make "prefix=$DDIR" all || error_in "Building $realname"
   make "prefix=$DDIR" install || error_in "Installing $realname"

   echo "Linking files to $BINDIR ..."
   for file in "$DDIR/bin/"*; do
      ln -sf $file "$BINDIR" || error_in "Linking $file"
   done
done
