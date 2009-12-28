#!/bin/sh
ddir="${HOME}/privat/firmen/ethz/vcs/logs/$(date +%Y)"
file=$(date +%Y-%m-%d)
dfile="${ddir}/${file}"

$EDITOR "${dfile}"
