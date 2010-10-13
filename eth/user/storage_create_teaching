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

if [ $# -lt 3 ]; then
   cat << eof
$0: <sharename> <groupowner> <member> [more_members]

   sharename: sg-<hs|fs><2year digit>-<name>"

   Requires NETHZ_USERNAME to be set.

   Example: NETHZ_USERNAME="nicosc" $0 sg-hs09-asl nicosc troscoe alonso

eof
   exit 1
fi

if [ -z "$NETHZ_USERNAME" ]; then
   echo "Error: Set \$NETHZ_USERNAME to your username"
   exit 1
fi

sendmail="/usr/sbin/sendmail"
to="systems-sysadmins@lists.inf.ethz.ch"
from="${NETHZ_USERNAME}@ethz.ch"

sharename="$1"; shift
groupowner="$1"; shift
members="$@"

dirname="$(echo $sharename | awk -F- '{ print $2 "/" $3 }')"

#cat << eof
cat << eof | $sendmail -f "$from" $to
To: systems-sysadmins@lists.inf.ethz.ch
Subject: New samba teaching export: $sharename

Dear Systems Group Sysadmins,

as ISG needs a verification from either an IK or a professor,
I would like you to forward the following information to ISG:

--------------------------------------------------------------------------------
ISG: Reply to $from for testing, the user is responsible for testing the share.
--------------------------------------------------------------------------------
ISG: Create the new Samba-only share

   $sharename

in the directory

    fs-systems.inf.ethz.ch:/export/groups/systems/p1/project/teaching/$dirname

and export it to the NEW unix group named

   $sharename

with the following members

   $members

with Samba permissions set to (see #109493)

   user systems
   group $sharename
   dir 2770
   files 660

and make the following person responsible for the group: 

   $groupowner

--------------------------------------------------------------------------------

Yes, my prof allowed me to create that share.

Cheers,

   $USER

eof
