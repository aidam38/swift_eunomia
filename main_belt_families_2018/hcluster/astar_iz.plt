#!/usr/bin/gnuplot

set colors classic
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

f_(H) = H > 0.0 ? 0.33 + (H-19.)/(4.-19.)*1.5 : NaN
g_(H) = 2.*f_(H)

p "family.list"     u 104:($100-$102):(g_($121)):(aiz($104, $100-$102)) with p pt 7 ps var lc rgb variable,\
  "interlopers.out" u 104:($100-$102) w p pt 6 lt 4 ps 1,\
  "family.label"    u 104:($100-$102):34 w labels center
pa -1

set term post eps enh color solid "Helvetica" 18
set out "astar_iz.eps"
rep

q


