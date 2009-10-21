#!/bin/sh
set -x
BDIR=~/b/ikiwiki
PERL5LIB=${BDIR}  ${BDIR}/ikiwiki.in \
	--libdir ${BDIR} \
	--templatedir ${BDIR}/templates \
	-set underlaydir=${BDIR}/underlays \
	-set underlaydirbase=${BDIR}/underlays \
	--setup ikiwiki.setup \
	--refresh
