#!/usr/bin/gnuplot

set colors classic
#set term x11

set xl "a_p [AU]"
set yl "e_p"
set zl "sin I_p"

load "check_BOX.rng"
set xr [a1:a2]
set yr [e1:e2]
set zr [sinI1:sinI2]

set ticslevel 0
set nokey
set view 90,0

load "COLOR_wise.plt"

#17 .. 0.1
# 6 .. 10
#f_(H) = 0.1 + (H-17.)/(6.-17.)*1.0
#f_(H) = 0.1 + (H-17.)/(6.-17.)*1.5

p_V = 0.15

f_(D) = 0.5 + (log10(D)-0.)/(3.-0.)*3.0

sp \
   "check_BOX.dat" u 36:37:38 w p pt 7 lt 9 ps 0.5,\
   "check_BOX.dat" u 36:37:38:(f_($47)):(pV_pIR($57, $59)) w p pt 7 ps variable lc rgb variable,\
   "check_BOX.lab" u 36:37:38:34 w labels center,\
   "../families.syn" u 36:37:38:34 w labels center
pa -1

set term post eps enh color solid "Helvetica" 18
set out "aei_wise.eps"
set size 3,3
rep

q
   "check_BOX.dat" u 36:37:38:(g_($48,$35)) w p pt 7 ps variable lt 9,\
g_(D, H) = D == "\?" ? f_(10.**(6.259 - log10(p_V) - 0.4*H)) : f_(D)


