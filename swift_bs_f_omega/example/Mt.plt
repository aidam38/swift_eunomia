#!/usr/bin/gnuplot

set xl "t [Myr]"
set yl "M [deg]"

#set xr [0:0.0001]
set yr [0:360]

p "<awk '($1==1)' follow.out" u 2:8,\
  "<awk '($1==-2)' follow.out" u 2:8
pa -1

set term png small
set out "Mt.png"
rep


