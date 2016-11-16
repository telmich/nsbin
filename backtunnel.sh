#!/bin/sh

ssh -R :4242:localhost:22 nico-vm.schottelius.org "while true; do date; done" > /dev/null
