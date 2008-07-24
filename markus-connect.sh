#!/bin/sh

term=x-terminal-emulator
term=xterm
host="$(basename $0)"

"${term}" -e "ssh ${host}; sleep 10"
