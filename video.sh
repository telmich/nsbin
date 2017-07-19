#!/bin/sh
mencoder mf://*-snapshot.jpg -mf w=960:h=720:fps=50:type=jpg -ovc lavc \
    -lavcopts vcodec=mpeg4:mbd=2:trell -oac copy -o output.avi
