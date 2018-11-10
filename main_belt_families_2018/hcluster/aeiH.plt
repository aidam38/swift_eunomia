#!/usr/bin/gnuplot

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

f_(H) = 0.1 + (H-17.)/(6.-17.)*1.5

sp \
   "family.list" u 36:37:38:(f_($35)) w p lt 7 pt 7 ps variable,\
   "family.label" u 36:37:38:34 w labels center
pa -1

set term post eps enh color solid "Helvetica" 18
set out "aeiH.eps"
rep

q



