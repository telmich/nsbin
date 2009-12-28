#!/bin/sh

NUM=`cat COUNT`
NUM=$(($NUM+1))

ln -s "$1" audio_${NUM}.wav

echo $NUM > COUNT
