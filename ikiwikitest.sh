#!/bin/sh
set -x
BDIR=~/b/ikiwiki

( cd "${BDIR}" && git describe )

START="$(date)"
PERL5LIB=${BDIR}  ${BDIR}/ikiwiki.in \
	--libdir ${BDIR} \
	--templatedir ${BDIR}/templates \
	-set underlaydir=${BDIR}/underlays \
	-set underlaydirbase=${BDIR}/underlays \
	--setup ikiwiki.setup \
   "$@"
ret=$?
END="$(date)"
echo ${START} - ${END}: ikiwiki result: $?
