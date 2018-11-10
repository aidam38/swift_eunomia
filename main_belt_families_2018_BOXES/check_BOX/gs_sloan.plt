#!/usr/bin/gnuplot

set xl "g [arcsec/yr]"
set yl "s [arcsec/yr]"

load "check_BOX.rng"
set xr [a1:a2]
set yr [e1:e2]
set zr [sinI1:sinI2]

set ticslevel 0
set nokey
set view 90,0
set pm3d map

load "COLOR_sloan.plt"

f_(H) = 0.1 + (H-17.)/(6.-17.)*1.5
g_(H) = 2.*f_(H)

sp "check_BOX.dat" u 40:41:41:(f_($35)) w p lt 9 pt 7 ps variable,\
   "check_BOX.dat" u 40:41:41:(g_($106)):(aiz($89, $85-$87)) w p pt 7 ps variable lc rgb variable,\
   "check_BOX.lab" u 40:41:41:34 w labels center,\
   "../families.syn" u 3:4:5:1 w labels center
pa -1

set term post eps enh color solid "Helvetica" 18
set out "gs_sloan.eps"
rep

q



