#!/usr/bin/env python3

import argparse
import datetime
import sys

mymap={
    'tweet': 2,
    'email': 2,
    'ticket': 3 }

wchoices = [ x for x in mymap ]

parser = argparse.ArgumentParser(description='Scoooooooring')

fname="/home/nico/vcs/notes/points.org"


parser.add_argument('-m', '--method', help="read / write", choices=["r", "w"], default="w")
parser.add_argument('-w', '--what', help="What I did", required=True, choices=wchoices)
parser.add_argument('-a', '--amount', help="How much of it", required=False, default=1)


args = parser.parse_args(sys.argv[1:])

count = int(args.amount)
when  = datetime.date.today().isoformat()
what  = args.what

if args.method == "w":
   with open(fname, "a") as fd:
      for x in range(count):
         to_print="| {} | {} |".format(when, what)
         print(to_print)
         fd.write(to_print)
         fd.write("\n")


else:
   print("ok")
