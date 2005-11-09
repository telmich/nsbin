#!/bin/sh
# Nico Schottelius
# Date: Mit Nov  9 12:57:04 CET 2005
# Last Modified: -
# 
# Install latest git and cogito to $INSTALL_PREFIX/$name and
# link the binaries to $BINDIR
# Needs git and cogito to work!

BASE_GET=http://www.kernel.org/pub/scm/
PROJECTS="git/git.git cogito/cogito.git"
BUILDDIR=/home/nico/build
INSTALL_PREFIX=/usr/packages
BINDIR=/usr/local/bin

for project in $PROJECTS; do
   realname=$(echo $project | sed -e 's,.*/,,' -e 's/\.git$//')

   echo "Working on $realname (in $BUILDDIR/$realname) ... "

   if [ ! -d "$BUILDDIR/$realname" ]; then
      echo "Cloning $realname"
      cg-clone "${BASE_GET}${project}" "$BUILDDIR/$realname"
   else
      echo "Updating $realname from \"origin\""
      cd "$BUILDDIR/$realname" || exit 1
      cg-update origin
   fi

   cd "$BUILDDIR/$realname"
   version=$(cg-object-id)
   echo "Installing $realname (Version: $version)"
   DDIR=$INSTALL_PREFIX/$realname-$version
   make "prefix=$DDIR" all
   make "prefix=$DDIR" install

   echo "Linking files to $BINDIR ..."
   for file in "$DDIR/bin/"*; do
      ln -sf $file "$BINDIR"
   done
done
