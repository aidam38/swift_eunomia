#!/usr/bin/gnuplot

set term x11

set xl "t [Myr]"
set yl "I [deg]"

p "<awk '($1 > 0)' follow.out" u 2:5 w d,\
  "<awk '($1==-2)' follow.out" u 2:5 w l

pa -1

