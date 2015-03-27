#!/bin/sh

limit=$1; shift

task list limit:$limit "$@"
