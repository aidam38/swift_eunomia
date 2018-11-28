#!/usr/bin/gnuplot

set colors classic
#set term x11

set xl "a_p [AU]"
set yl "e_p"
set zl "sin I_p"

load "family.rng"
set xr [a1:a2]
set yr [e1:e2]
set zr [i1:i2]

set ticslevel 0
set nokey
set view 90,0

load "COLOR_sloan.plt"

f_(H) = H > 0.0 ? 0.33 + (H-19.)/(4.-19.)*1.5 : NaN
g_(H) = 2.*f_(H)

sp "family.list"     u 36:37:38:(f_($35)) w p lt 2 pt 7 ps variable,\
   "family.list"     u 36:37:38:(g_($121)):(aiz($104, $100-$102)) w p pt 7 ps variable lc rgb variable,\
   "family.label"    u 36:37:38:34 w labels center,\
   "interlopers.out" u 36:37:38 w p pt 6 lt 1 ps 1,\
   "../families.syn" u 36:37:38:34 w labels center
pa -1

set term post eps enh color solid "Helvetica" 18
set out "aei_sloan.eps"
rep

q



