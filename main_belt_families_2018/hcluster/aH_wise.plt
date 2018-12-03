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

set yr [3:]

set ticslevel 0
set nokey
set view 0,0
set samples 1000

load "COLOR_wise.plt"
load "family.rng"

H(a,a_c,C)= log10(abs(a-a_c)/C)/ 0.2

f_(D) = (0.5 + (log10(D)-0.)/(3.-0.)*3.0)*0.5

p_V = 0.15
D(H, p_V) = 10.**(0.5*(6.259 - log10(p_V) - 0.4*H))

p \
   "<awk '($48 == \"?\")' family.list" u 36:35:(f_(D($35,p_V))) w p pt 7 ps variable lc 9,\
   "<awk '($48 != \"?\")' family.list" u 36:35:(f_($47)):(pV_pIR($57, $59)) w p pt 7 ps variable lc rgb variable,\
   "family.label" u 36:35:34 w labels center,\
   "interlopers.out" u 36:35 not w p lt 2 pt 6 ps 1,\
   H(x,a_c,C)       not lt 10 lw 3
#pa -1

set term post eps enh color solid "Helvetica" 18
set out "aH_wise.eps"
rep

q

   "<awk '($35 < 13)' family.list" u 36:35:34 w labels center
