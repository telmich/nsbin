#!/bin/sh
# Nico Schottelius
# Mirror some ftp site and record changes
# Run before:
# cd "${dir}" && git init

set -e

dir=/home/users/nico/ethz/ftp
site=ftp://ftp.ethz.ch/ETH
date="$(date)"

cd "${dir}"
wget --quiet -m ${site}
git add . && git c -m "Import of ${site} at ${date}" > /dev/null
