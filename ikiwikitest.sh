#!/bin/sh
set -x
BDIR=~/p/foreign/ikiwiki

( cd "${BDIR}" && git describe )

START="$(date)"
PERL5LIB=${BDIR}  ${BDIR}/ikiwiki.in \
	--setup ikiwiki.setup \
	--templatedir ${BDIR}/templates \
   "$@"
ret=$?
END="$(date)"
echo ${START} - ${END}: ikiwiki result: $?

#	-set underlaydir=${BDIR}/underlays/basewiki \
#	-set underlaydirbase=${BDIR}/underlays \
#	--libdir ${BDIR} \
