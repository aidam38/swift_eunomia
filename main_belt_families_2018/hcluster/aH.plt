#!/usr/bin/gnuplot

set colors classic
#set term x11

H(a,a_c,C)= log10(abs(a-a_c)/C)/ 0.2

set xl "a_p [AU]"
set yl "H [mag]"

C = NaN

load "family.rng"
#set xr [a1:a2]
#set yr [e1:e2]
#set zr [i1:i2]
#set yr [H1-1:H2+1]

set ticslevel 0
set key
set view 90,0
set samples 300

load "COLOR_sloan.plt"

f_(H) = 0.33 + (H-19.)/(6.-19.)*1.5
   H(x,a_c,C)       not lt 10 lw 3
g_(H) = 1.*f_(H)

p \
   H(x,a_c,0.01e-4) t "C*1e-4 = 0.01" lt 1,\
   H(x,a_c,0.02e-4) t "0.02" lt 2,\
   H(x,a_c,0.05e-4) t "0.05" lt 3,\
   H(x,a_c,0.1e-4 ) t "0.1" lt 4,\
   H(x,a_c,0.2e-4 ) t "0.2" lt 5,\
   H(x,a_c,0.5e-4 ) t "0.5" lt 6,\
   H(x,a_c,1.0e-4 ) t "1.0" lt 7,\
   H(x,a_c,2.0e-4 ) t "2.0" lt 8,\
   H(x,a_c,5.0e-4 ) t "5.0" lt 9,\
   "family.list"                   u 36:35:(f_($35)) not w p lt 9 pt 7 ps variable,\
   "family.list"                   u 36:35:(g_($106)):(aiz($89, $85-$87)) not w p pt 7 ps variable lc rgb variable,\
   "interlopers.out"               u 36:35 not w p lt 2 pt 6 ps 1,\
   "family.label"                  u 36:35:34 not w labels center,\
   "<awk '($35 < 12)' family.list" u 36:35:34 not w labels center,\
   H(x,a_c,C)       not lt 10 lw 3

pa -1

set term post eps enh color solid "Helvetica" 18
set out "aH.eps"
rep

q


