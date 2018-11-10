#!/usr/bin/gnuplot

set colors classic
set term x11

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

load "COLOR_wise.plt"

f_(D) = 0.5 + (log10(D)-0.)/(3.-0.)*3.0

p_V = 0.15
D(H, p_V) = 10.**(0.5*(6.259 - log10(p_V) - 0.4*H))

sp \
   "<awk '($48 == \"?\")' family.list" u 36:35:38:(f_(D($35,p_V))) w p pt 7 ps variable lc 9,\
   "<awk '($48 != \"?\")' family.list" u 36:35:38:(f_($47)):(pV_pIR($57, $59)) w p pt 7 ps variable lc rgb variable,\
   "family.label" u 36:35:38:34 w labels center,\
   "interlopers.out" u 36:35:38 not w p lt 2 pt 6 ps 1,\
   "<awk '($35 < 13)' family.list" u 36:35:38:34 w labels center
pa -1

set term post eps enh color solid "Helvetica" 18
set out "aH_wise.eps"
rep


