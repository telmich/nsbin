#!/bin/sh
set -x
BDIR=~/b/ikiwiki

( cd "${BDIR}" && git describe )

START="$(date)"
PERL5LIB=${BDIR}  ${BDIR}/ikiwiki.in \
	--setup ikiwiki.setup \
   "$@"
ret=$?
END="$(date)"
echo ${START} - ${END}: ikiwiki result: $?

#	-set underlaydir=${BDIR}/underlays/basewiki \
#	-set underlaydirbase=${BDIR}/underlays \
#	--libdir ${BDIR} \
#	--templatedir ${BDIR}/templates \
