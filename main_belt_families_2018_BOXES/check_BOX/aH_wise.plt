#!/usr/bin/gnuplot

set term x11

set xl "a_p [AU]"
set yl "H [mag]"
set zl "sin I_p"

load "check_BOX.rng"
set xr [a1:a2]
#set yr [e1:e2]
set zr [sinI1:sinI2]

set ticslevel 0
set nokey
set view 0,0

load "COLOR_wise.plt"

#17 .. 0.1
# 6 .. 10
#f_(H) = 0.1 + (H-17.)/(6.-17.)*1.0
#f_(H) = 0.1 + (H-17.)/(6.-17.)*1.5

p_V = 0.15

f_(D) = 0.2 + (log10(D)-0.)/(3.-0.)*3.0

sp \
   "check_BOX.dat" u 36:35:38 w p pt 7 lt 9 ps 0.2,\
   "check_BOX.dat" u 36:35:38:(f_($48)):(pV_pIR($50, $54)) w p pt 7 ps variable lc rgb variable
pa -1

set term post eps enh color solid "Helvetica" 18
set out "aH_wise.eps"
rep

q
   "../families.syn" u 3:2:5:1 w labels center
   "check_BOX.dat" u 36:37:38:(g_($48,$35)) w p pt 7 ps variable lt 9,\
g_(D, H) = D == "\?" ? f_(10.**(6.259 - log10(p_V) - 0.4*H)) : f_(D)


