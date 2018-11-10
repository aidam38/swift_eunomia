#!/usr/bin/gnuplot

#set term x11

set xl "a^* [mag]"
set yl "i-z [mag]"

tmp=3.0
tmp=0.5
set xr [-tmp:tmp]
set yr [-tmp:tmp]
set size ratio -1

set zeroaxis
set ticslevel 0
set pm3d map
set nokey

load "COLOR_sloan.plt"

p "check_BOX.dat" u 104:($100-$102):(aiz($104, $100-$102)) with p pt 7 ps 1.0 lc rgb variable,\
  "check_BOX.lab" u 104:($100-$102):34 w labels center
pa -1

set term post eps enh color solid "Helvetica" 18
set out "astar_iz.eps"
rep

q


