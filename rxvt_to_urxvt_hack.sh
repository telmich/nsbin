#!/bin/sh
#===============================================================================
# Author: Nico Schottelius
# Created: 2007-01-04
# Description: rxvt is known to most systems, urxvt not. Hack it.
#==============================================================================

echo '[ "$TERM" = "rxvt-unicode" ] && export TERM=rxvt' >> "$HOME/.profile"
echo 'if ( $TERM == rxvt-unicode ) setenv TERM rxvt' >> "$HOME/.cshrc"
