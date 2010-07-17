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
$0: <repo-name> <repo-admin> <trac|notrac> [comments]

   trac: Also create a trac instance for the svn repo.

   Requires NETHZ_USERNAME to be set.

   Example: NETHZ_USERNAME="nicosc" $0 coolcode troscoe trac Add write permissions for group xyz

eof
   exit 1
fi

if [ -z "$NETHZ_USERNAME" ]; then
   echo "Error: Set \$NETHZ_USERNAME to your username"
   exit 1
fi

sendmail="/usr/sbin/sendmail"
to="support@inf.ethz.ch systems-sysadmins@lists.inf.ethz.ch"
to="nicosc@ethz.ch"
from="${NETHZ_USERNAME}@ethz.ch"

reponame="$1"; shift
repoowner="$1"; shift
trac="$1"; shift

if [ "$trac" = trac ]; then
   tracflag="on"
else
   tracflag="off"
fi

cat << eof | $sendmail -f "$from" $to
To: support@inf.ethz.ch, systems-sysadmins@lists.inf.ethz.ch
Subject: Request for new svn repo $reponame for OU Systems

Comments:         $@
Repository admin: $repoowner
Repository name:  $reponame
With Trac:        $tracflag
eMail address:    $from
group:            Systems

Cheers,

   $USER

eof
