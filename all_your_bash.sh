#!/bin/bash
# All your bash are belong to us...
# This is a harmless bash script... really!
# Written out of pure boredom.
# Terminal capable of ANSI color sequences recommended.

# - fuzzy

__="echo -ne ";___="return";:(){ [ $1 -lt 10 ] || { $__ "  "; $___;}; 
[ $((($4*$4)+($5*$5))) -gt 40000000 ] && { $__ "\033[3"$1"m##";$___;};
: $(($1+1)) $2 $3 $((((($4*$4)-($5*$5))/1000)+$2)) $(((2*$4*$5)/1000+$3));};:_ (){
[ $2 -lt 1600 ] || { $__ "\n" ;$___;};: 0 $2 $1 0 0;:_ $1 $(($2+100 ));};:__(){ 
[ $1 -lt 1600 ] || $___;:_ $1 -2500;:__ $(($1+100));};:__ -1500
