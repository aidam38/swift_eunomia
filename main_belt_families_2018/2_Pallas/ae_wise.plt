#!/usr/bin/gnuplot

set colors classic
set term x11

#set xl "{/Helvetica-Oblique a}_p [AU]"
set yl "{/Helvetica-Oblique e}_p" offset 1.5,0

a = 2.77092
e = 0.281258
sini = 0.547547

load "family.rng"
#set xr [a1:a2]
e1 = 0.15
e2 = 0.32
set yr [e1:e2]
tmp=0.13
set xr [a-tmp:a+tmp]
#tmp=0.100/2.
#set yr [e-tmp:e+tmp]

#set xtics 0.01
set ytics 0.02
set mytics 2
set ticslevel 0
set key samplen 0.5 font "Helvetica,12"
set view 90,0

load "COLOR_wise.plt"

#17 .. 0.1
# 6 .. 10
#f_(H) = 0.1 + (H-17.)/(6.-17.)*1.0
#f_(H) = 0.1 + (H-17.)/(6.-17.)*1.5

f_(D) = 0.5 + (log10(D)-0.)/(3.-0.)*3.0

p_V = 0.15
D(H, p_V) = 10.**(0.5*(6.259 - log10(p_V) - 0.4*H))

set lmargin 7.5
set rmargin 1.2
set bmargin 0.5
set tmargin 1.1

a_J = 5.2027129998802337
r(a,i,j) = a*(1.0*i/j)**(-2./3.)
a_J52=r(a_J,5,2)
set arrow from a_J52,graph 0 to a_J52,graph 1 lt 0 nohead front
set label "J5/2" at a_J52,graph 1.025 center font "Helvetica,14"

tmp=r(a_J,8,3)
set arrow from tmp,graph 0 to tmp,graph 1 lt 0 nohead front
set label "J8/3" at tmp,graph 1.025 center font "Helvetica,12"

a = 2.75
i_over_j = (a/a_J)**(3./2.)
print "i/j = ", i_over_j*13

tmp=r(a_J,13,5)
set arrow from tmp,graph 0 to tmp,graph 1 lt 0 nohead front
set label "J13/5" at tmp,graph 1.025 center font "Helvetica,12"

x1 = a_J52-0.02
x2 = a_J52+0.02
y1 = e1
y2 = e2
e_ = 0.27

load "../../secres/ranges.plt"

p \
  "box.dat" u (x1+$1*(x2-x1)):(y1+$2*(y2-y1)) not w filledcurves lt 9 lw 0.0 fill pattern 4,\
  sprintf("<./v_gauss/genvel_ellip 300 361 -1 | ./v_gauss/v_gauss 2.77092 %.8f 130.0 0.0 | awk '(FNR>1)'", e_) u (a+$1):(e_+$2) not w l lt 2 lc 9 lw 0.5,\
  sprintf("<./v_gauss/genvel_ellip 300 361 -1 | ./v_gauss/v_gauss 2.77092 %.8f 140.0 0.0 | awk '(FNR>1)'", e_) u (a+$1):(e_+$2) not w l lt 2 lc 9 lw 2.5,\
  sprintf("<./v_gauss/genvel_ellip 300 361 -1 | ./v_gauss/v_gauss 2.77092 %.8f 150.0 0.0 | awk '(FNR>1)'", e_) u (a+$1):(e_+$2) not w l lt 2 lc 9 lw 0.5,\
  sprintf("<./v_gauss/genvel_ellip 300 361 -1 | ./v_gauss/v_gauss 2.77092 %.8f 160.0 0.0 | awk '(FNR>1)'", e_) u (a+$1):(e_+$2) not w l lt 2 lc 9 lw 0.5,\
  sprintf("<./v_gauss/genvel_ellip 300 361 -1 | ./v_gauss/v_gauss 2.77092 %.8f 170.0 0.0 | awk '(FNR>1)'", e_) u (a+$1):(e_+$2) not w l lt 2 lc 9 lw 0.5,\
  "<awk '($48 == \"?\")' family.list" u 36:37:(f_(D($35,p_V))) not w p pt 7 ps variable lc 7,\
  "<awk '($48 != \"?\")' family.list" u 36:37:(f_($47)):(pV_pIR($57, $59)) not w p pt 7 ps variable lc rgb variable,\
  "interlopers.out" u 36:37 not w p pt 6 lt 2 ps 1,\
  "../../secres/ae/d10_cntr.dat"         u ($1/ngrid*(amax-amin)+amin):(emax-$2/ngrid*(emax-emin)) title "g+s-g6-s6"   w lines,\
  "../../secres/ae/d13_cntr.dat"         u ($1/ngrid*(amax-amin)+amin):(emax-$2/ngrid*(emax-emin)) title "g-2g6+g5"    w lines,\
  "../../secres/ae/d46_cntr.dat"         u ($1/ngrid*(amax-amin)+amin):(emax-$2/ngrid*(emax-emin)) title "{/Helvetica-Oblique s}-{/Helvetica-Oblique s}_6-{/Helvetica-Oblique g}_5+{/Helvetica-Oblique g}_6"  w lines lt 0,\
  "../../secres/ae/d2_cntr.dat"          u ($1/ngrid*(amax-amin)+amin):(emax-$2/ngrid*(emax-emin)) title "nu6"         w lines,\
  "../../secres/ae/z2_cntr.dat"          u ($1/ngrid*(amax-amin)+amin):(emax-$2/ngrid*(emax-emin)) title "z2"          w lines,\
  "../../secres/ae/z3_cntr.dat"          u ($1/ngrid*(amax-amin)+amin):(emax-$2/ngrid*(emax-emin)) title "z3"          w lines,\
  "../../secres/ae/d61_cntr.dat"         u ($1/ngrid*(amax-amin)+amin):(emax-$2/ngrid*(emax-emin)) title "g-3g6+2g5"   w lines,\
  "../../secres/ae/g_s_g5_s6_cntr.dat"   u ($1/ngrid*(amax-amin)+amin):(emax-$2/ngrid*(emax-emin)) title "g+s-g5-s6"   w lines,\
  "../../secres/ae/2g_g5_g6_cntr.dat"    u ($1/ngrid*(amax-amin)+amin):(emax-$2/ngrid*(emax-emin)) title "2g-g5-g6"    w lines,\
  "../../secres/ae/2g_s_2g5_s7_cntr.dat" u ($1/ngrid*(amax-amin)+amin):(emax-$2/ngrid*(emax-emin)) title "2g+s-2g5-s7" w lines
#pa -1

set term post eps enh color dashed "Helvetica" 18
set size 0.8,0.75
set out "ae_wise.eps"
rep

q

   "<./v_gauss/genvel_ellip 300 361 -1 | ./v_gauss/v_gauss 2.77092 0.281258 160.0 0.0 | awk '(FNR>1)'" u (a+$1):(e   +$2) not w l lt 2 lc 9 lw 0.5,\
   "family.label" u 36:38:34 w labels center,\
   "../families.syn" u 36:38:34 w labels center

