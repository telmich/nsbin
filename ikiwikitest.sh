#!/bin/sh
set -x
BDIR=~/b/ikiwiki

( cd "${BDIR}" && git describe )

PERL5LIB=${BDIR}  ${BDIR}/ikiwiki.in \
	--libdir ${BDIR} \
	--templatedir ${BDIR}/templates \
	-set underlaydir=${BDIR}/underlays \
	-set underlaydirbase=${BDIR}/underlays \
	--setup ikiwiki.setup \
   "$@"
echo ikiwiki result: $?
