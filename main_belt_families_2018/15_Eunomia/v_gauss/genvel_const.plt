#!/usr/bin/gnuplot

#set term x11

set xl "vx [m/s]"
set yl "vy [m/s]"
set zl "vz [m/s]"

tmp=10
set xr [-tmp:tmp]
set yr [-tmp:tmp]
set zr [-tmp:tmp]

set ticslevel 0
#set ticslevel -0.5
set size 0.666,1
set view 90,0,1,1

sp "<./zeros.awk genvel_const.out" u 1:2:3 w l
pa -1
q



