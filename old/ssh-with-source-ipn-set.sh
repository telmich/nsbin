#!/bin/sh
rhost=nico@62.65.141.133
bhost=62.65.149.149

ssh -t "${rhost}" "set -x; ssh -b \"${bhost}\" $@"
