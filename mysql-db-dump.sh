#!/bin/sh
# Nico Schottelius
# written for SyGroup (www.sygroup.ch)
# Date: Fr Nov 18 11:41:25 CET 2005
# Last Modified:

if [ $# -ne 1 ]; then exit 23; fi

DB=$1

export DESTDIR=/home/server/backup/db/
export GITDIR=/home/server/git/datenbank
export LOG=/var/log/gitdump.log
export DATUM=$(date +%Y-%m-%d)
export ZEIT=$(date +%H:%M)

export DDIR="$DESTDIR/$DATUM"
export DFILE="$DDIR/$ZEIT"
export GITFILE="$GITDIR/current"

echo "Start: $(date) $DB" >> "$LOG"

mkdir -p "$DDIR"
#
#   -u root           \
#   -p                \
# Dump ins archiv mit heilen umlauten, unlesbar
mysqldump            \
   --opt        \
   --add-drop-table  \
   --add-locks       \
   --all             \
   --quick           \
   --lock-tables     \
   "$DB"             > ${DFILE}

#ln -f "$DFILE" "$GITDIR/current"

# Dump ins git mit kaputten umlauten, aber lesbar
mysqldump            \
   --skip-opt        \
   --add-drop-table  \
   --add-locks       \
   --all             \
   --quick           \
   --lock-tables     \
   -c                \
   "$DB"             > ${GITFILE}

( cd "$GITDIR"; cg-commit -m "DB-Dump: $DB vom $DATUM um $ZEIT" >> "$LOG" 2>&1 )

echo "Ende: $(date) $DB" >> "$LOG"

