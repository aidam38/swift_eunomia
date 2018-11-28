#!/usr/bin/gnuplot

set colors classic
#set term x11

set xl "a_p [AU]"
set yl "H [mag]"
set zl "sin I_p"

#load "family.rng"
#set xr [a1:a2]
#set yr [e1:e2]
#set zr [i1:i2]

set ticslevel 0
set nokey
set view 0,0

load "COLOR_sloan.plt"

f_(H) = 0.33 + (H-19.)/(6.-19.)*1.5
g_(H) = 2.*f_(H)

sp "family.list" u 36:35:38:(f_($35)) w p lt 9 pt 7 ps variable,\
   "family.list" u 36:35:38:(g_($121)):(aiz($104, $100-$102)) w p pt 7 ps variable lc rgb variable,\
   "family.label" u 36:35:38:34 w labels center,\
   "interlopers.out" u 36:35:38 not w p lt 2 pt 6 ps 1,\
   "<awk '($35 < 12)' family.list" u 36:35:38:34 w labels center

pa -1

set term post eps enh color solid "Helvetica" 18
set out "aH_sloan.eps"
rep

q



