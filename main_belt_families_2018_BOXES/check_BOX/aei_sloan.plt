#!/usr/bin/gnuplot

set colors classic

set xl "a_p [AU]"
set yl "e_p"
set zl "sin I_p"

load "check_BOX.rng"
set xr [a1:a2]
set yr [e1:e2]
set zr [sinI1:sinI2]

set ticslevel 0
set nokey
set view 0,0

load "COLOR_sloan.plt"

f_(H) = H > 0 ? 1.*(0.33 + (19.-H)/(19.-4.)*1.5) : NaN
g_(H) = 1.*f_(H)

sp \
   "check_BOX.dat"   u 36:37:38:(f_($35)) w p lt 2 pt 7 ps variable,\
   "check_BOX.dat"   u 36:37:38:(g_($121)):(aiz($104, $100-$102)) w p pt 7 ps variable lc rgb variable,\
   "check_BOX.lab"   u 36:37:38:34 w labels center,\
   "../families.syn" u 36:37:38:34 w labels center
pa -1

set term post eps enh color solid "Helvetica" 18
set out "aei_sloan.eps"
set size 3,3
rep

q


