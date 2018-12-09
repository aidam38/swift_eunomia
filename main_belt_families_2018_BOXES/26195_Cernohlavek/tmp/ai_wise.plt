#!/usr/bin/gnuplot

set term x11

set xl "{/Helvetica-Oblique a}_p [AU]"
set yl "sin {/Helvetica-Oblique I}_p" offset +1,0

load "check_BOX.rng"
set xr [a1:a2]
set yr [sinI1:sinI2]

set ticslevel 0
set nokey
set grid noxtics noytics front

load "COLOR_wise.plt"

#17 .. 0.1
# 6 .. 10
#f_(H) = 0.1 + (H-17.)/(6.-17.)*1.0
#f_(H) = 0.1 + (H-17.)/(6.-17.)*1.5

p_V = 0.15

f_(D) = 0.2 + (log10(D)-0.)/(3.-0.)*3.0

a_J = 5.2027129998802337
a_J31 = a_J*(3./1.)**(-2./3.)
print "a_J31 = ", a_J31, " au"
set arrow from a_J31,graph 0 to a_J31,graph 1 lt 0 nohead
set label "J3/1" at a_J31,graph 1.025 center font "Helvetica,14"

set lmargin 8.0
set rmargin 1.5
set bmargin 3.2
set tmargin 1.0

p \
   "check_BOX.dat" u 36:38 w p pt 7 lt 9 ps 0.33,\
   "89_Julia_family.list_80" u 36:38 w p pt 7 lt 8 ps 0.33,\
   "check_BOX.dat" u 36:38:(f_($48)):(pV_pIR($50, $54)) w p pt 7 ps variable lc rgb variable,\
   sprintf("<awk '($36>%f) && ($36<%f) && ($37>%f) && ($37<%f) && ($38>%f) && ($38<%f)' ../families.syn", a1,a2,e1,e2,sinI1,sinI2) u 36:38:34 w labels center font "Helvetica,12",\
#pa -1

set term post eps enh color solid "Helvetica" 18
set out "ai_wise.eps"
set size 0.8,0.9
rep

q

   "<awk '($1<100)' check_BOX.dat" u 36:38:34 w labels center,\
   sprintf("<awk '($36>%f) && ($36<%f) && ($37>%f) && ($37<%f) && ($38>%f) && ($38<%f)' ../families.syn", a1,a2,e1,e2,sinI1,sinI2) u 36:38:34 w labels center font "Helvetica,12" tc rgb "white"
   "check_BOX.lab" u 36:38:34 w labels center,\

