#!/bin/sh
ddir="${HOME}/privat/persoenlich/notizen"
file=$(date +%Y-%m-%d)
dfile="${ddir}/${file}"

vi "${dfile}"
