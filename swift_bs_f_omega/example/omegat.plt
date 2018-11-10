#!/usr/bin/gnuplot

set xl "t [Myr]"
set yl "omega [deg]"

set yr [0:360]

p "<awk '($1==1)' follow.out" u 2:7,\
  "<awk '($1==-2)' follow.out" u 2:7
pa -1

set term png small
set out "omegat.png"
rep


