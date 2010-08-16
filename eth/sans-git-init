#!/bin/sh
# 
# 2008      Nico Schottelius (nico-nsbin at schottelius.org)
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
# Usage: $0 repo desc pseudo-owner
#

basedir=/home/services/sans/git
group=sans

repo="$1"; shift
desc="$1"; shift
powner="$1"; shift

export GIT_DIR="${basedir}/${repo}"

git init --shared=group --bare

# allow display via gitweb
touch "${GIT_DIR}/git-daemon-export-ok"

# add description
echo "${desc}" > "${GIT_DIR}/description"

# make sure group rights are kept
cat << eof > "${GIT_DIR}/config"
[core]
        filemode = true
        bare = true
        sharedRepository = group
[gitweb]
        owner = "${powner:-"sans"}"
eof

chgrp sans -R "${GIT_DIR}"
chmod g+rw -R "${GIT_DIR}"
