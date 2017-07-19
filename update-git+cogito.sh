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


#
# Configuration
#
BUILDDIR=${BUILDDIR:-/home/user/nico/build}
INSTALL_PREFIX=${INSTALL_PREFIX:-/usr/packages}
BINDIR=${BINDIR:-/usr/local/bin}
MAKE=${MAKE:-make}


#
# No configuration needed below here
#

BASE_GET=http://www.kernel.org/pub/scm/
PROJECTS="git cogito"
# urls for initial cloning
git_url=http://www.kernel.org/pub/software/scm/git/
cogito_url=http://www.kernel.org/pub/software/scm/cogito/

error_in()
{
   echo "[failed] $1"
   echo "Exiting now."
   exit 1
}


for project in $PROJECTS; do
   echo "Working on $project (in $BUILDDIR/$project) ... "
   
   
   # Test for existence: if git or cogito is missing, install it from
   # the current archive
   which $project > /dev/null

   if [ $? -ne 0 ]; then
      echo "$project not found, installing from archive"
      
      eval base_url=\$${project}_url
      get_url=$(lynx -dump "$base_url" | awk "/$project-([0-9]\.)*tar.bz2\$/ { print \$2 }" | sort -n | tail -n 1)
   
      echo "Retrieving $project from $get_url"
   fi

   if [ ! -d "$BUILDDIR/$project" ]; then
      echo "Cloning $project"
      cg-clone "${BASE_GET}${project}/${project}.git" "$BUILDDIR/$project"
   else
      echo "Updating $project from \"origin\""
      cd "$BUILDDIR/$project" || error_in "$BUILDDIR/$project"
      cg-update origin
   fi

   if [ $? -ne 0 ]; then
      echo "Pull or clone failed, ABORTING."
      exit 23
   fi

   cd "$BUILDDIR/$project"
   version=$(cg-object-id)
   echo "Installing $project (Version: $version)"
   DDIR=$INSTALL_PREFIX/$project-$version
   $MAKE clean || error_in "Cleaning $project"
   $MAKE "prefix=$DDIR" all || error_in "Building $project"
   $MAKE "prefix=$DDIR" install || error_in "Installing $project"

   echo "Linking files to $BINDIR ..."
   for file in "$DDIR/bin/"*; do
      ln -sf $file "$BINDIR" || error_in "Linking $file"
   done
done
