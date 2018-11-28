#!/usr/bin/gnuplot

set colors classic
#set term x11
set ang deg

set xl "{/Helvetica-Oblique a}_p [au]"
set yl "sin {/Helvetica-Oblique I}_p" offset 1.5,0

a = 2.643666 
e = 0.1485956 
sini = 0.2266469

load "family.rng"
i1=0.20
i2=0.25
#set xr [a1:a2]
set yr [i1:i2]
tmp=0.13
set xr [a-tmp:a+tmp]

#set xtics 0.01
set ytics 0.01
#set mytics 2
set ticslevel 0
set key samplen 0.5 font "Helvetica,12"
set view 90,0

load "COLOR_wise.plt"

#17 .. 0.1
# 6 .. 10
#f_(H) = 0.1 + (H-17.)/(6.-17.)*1.0
#f_(H) = 0.1 + (H-17.)/(6.-17.)*1.5

f_(D) = 0.5 + (log10(D)-0.)/(3.-0.)*1.5

p_V = 0.15
D(H, p_V) = 10.**(0.5*(6.259 - log10(p_V) - 0.4*H))

set lmargin 7.5
set rmargin 1.2
set bmargin 3.2
set tmargin 0.6

a_J = 5.2027129998802337
r(a,i,j) = a*(1.0*i/j)**(-2./3.)
a_J52=r(a_J,5,2)
set arrow from a_J52,graph 0 to a_J52,graph 1 lt 0 nohead front

tmp=r(a_J,8,3)
set arrow from tmp,graph 0 to tmp,graph 1 lt 0 nohead front

tmp=r(a_J,13,5)
set arrow from tmp,graph 0 to tmp,graph 1 lt 0 nohead front

x1 = a_J52-0.02
x2 = a_J52+0.02
y1 = i1
y2 = i2

load "../../secres/ranges.plt"

p \
  "box.dat" u (x1+$1*(x2-x1)):(y1+$2*(y2-y1)) not w filledcurves lt 9 lw 0.0 fill pattern 4,\
  "<awk '($48 == \"?\")' family.list" u 36:38:(f_(D($35,p_V))) not w p pt 7 ps variable lc 7,\
  "<awk '($48 != \"?\")' family.list" u 36:38:(f_($47)):(pV_pIR($57, $59)) not w p pt 7 ps variable lc rgb variable,\
  "interlopers.out" u 36:38 not w p pt 6 lt 2 ps 1,\
  "../../secres/ai/d46_cntr.dat"         u ($1/ngrid*(amax-amin)+amin):(sin(imax-$2/ngrid*(imax-imin))) title "{/Helvetica-Oblique s}-{/Helvetica-Oblique s}_6-{/Helvetica-Oblique g}_5+{/Helvetica-Oblique g}_6"  w lines lt 0,\
  "<./v_gauss/genvel_ellip2 300 350 -1 | ./v_gauss/v_gauss 2.643666 0.1485956 0.0 0.0 | awk '(FNR>1)'" u (a+$1):(sini+$3) not w l lt 2 lc 9 lw 0.5,\
  "<./v_gauss/genvel_ellip2 300 350 -1 | ./v_gauss/v_gauss 2.643666 0.1485956 90.0 0.0 | awk '(FNR>1)'" u (a+$1):(sini+$3) not w l lt 2 lc 9 lw 0.5,\
  "<./v_gauss/genvel_ellip2 300 350 -1 | ./v_gauss/v_gauss 2.643666 0.1485956 180.0 0.0 | awk '(FNR>1)'" u (a+$1):(sini+$3) not w l lt 2 lc 9 lw 0.5,\
  "<./v_gauss/genvel_ellip2 300 350 -1 | ./v_gauss/v_gauss 2.643666 0.1485956 0.0 30.0 | awk '(FNR>1)'" u (a+$1):(sini+$3) not w l lt 2 lc 9 lw 0.5,\
  "<./v_gauss/genvel_ellip2 300 350 -1 | ./v_gauss/v_gauss 2.643666 0.1485956 90.0 30.0 | awk '(FNR>1)'" u (a+$1):(sini+$3) not w l lt 2 lc 9 lw 0.5,\
  "<./v_gauss/genvel_ellip2 300 350 -1 | ./v_gauss/v_gauss 2.643666 0.1485956 180.0 30.0 | awk '(FNR>1)'" u (a+$1):(sini+$3) not w l lt 2 lc 9 lw 0.5,\
  "<./v_gauss/genvel_ellip2 300 350 -1 | ./v_gauss/v_gauss 2.643666 0.1485956 0.0 60.0 | awk '(FNR>1)'" u (a+$1):(sini+$3) not w l lt 2 lc 9 lw 0.5,\
  "<./v_gauss/genvel_ellip2 300 350 -1 | ./v_gauss/v_gauss 2.643666 0.1485956 90.0 60.0 | awk '(FNR>1)'" u (a+$1):(sini+$3) not w l lt 2 lc 9 lw 0.5,\
  "<./v_gauss/genvel_ellip2 300 350 -1 | ./v_gauss/v_gauss 2.643666 0.1485956 180.0 60.0 | awk '(FNR>1)'" u (a+$1):(sini+$3) not w l lt 2 lc 9 lw 0.5,\
  "<./v_gauss/genvel_ellip2 300 350 -1 | ./v_gauss/v_gauss 2.643666 0.1485956 0.0 90.0 | awk '(FNR>1)'" u (a+$1):(sini+$3) not w l lt 2 lc 9 lw 0.5,\
  "<./v_gauss/genvel_ellip2 300 350 -1 | ./v_gauss/v_gauss 2.643666 0.1485956 90.0 90.0 | awk '(FNR>1)'" u (a+$1):(sini+$3) not w l lt 2 lc 9 lw 0.5,\
  "<./v_gauss/genvel_ellip2 300 350 -1 | ./v_gauss/v_gauss 2.643666 0.1485956 180.0 90.0 | awk '(FNR>1)'" u (a+$1):(sini+$3) not w l lt 2 lc 9 lw 0.5

pa -1

set term post eps enh color dashed "Helvetica" 18
set size 0.8,0.475
set out "ai_wise.eps"
rep

q

  "../../secres/ai/d10_cntr.dat"         u ($1/ngrid*(amax-amin)+amin):(sin(imax-$2/ngrid*(imax-imin))) title "g+s-g6-s6"   w lines,\
  "../../secres/ai/d13_cntr.dat"         u ($1/ngrid*(amax-amin)+amin):(sin(imax-$2/ngrid*(imax-imin))) title "g-2g6+g5"    w lines,\
  "../../secres/ai/d2_cntr.dat"          u ($1/ngrid*(amax-amin)+amin):(sin(imax-$2/ngrid*(imax-imin))) title "nu6"         w lines,\
  "../../secres/ai/z2_cntr.dat"          u ($1/ngrid*(amax-amin)+amin):(sin(imax-$2/ngrid*(imax-imin))) title "z2"          w lines,\
  "../../secres/ai/z3_cntr.dat"          u ($1/ngrid*(amax-amin)+amin):(sin(imax-$2/ngrid*(imax-imin))) title "z3"          w lines,\
  "../../secres/ai/d61_cntr.dat"         u ($1/ngrid*(amax-amin)+amin):(sin(imax-$2/ngrid*(imax-imin))) title "g-3g6+2g5"   w lines,\
  "../../secres/ai/g_s_g5_s6_cntr.dat"   u ($1/ngrid*(amax-amin)+amin):(sin(imax-$2/ngrid*(imax-imin))) title "g+s-g5-s6"   w lines,\
  "../../secres/ai/2g_g5_g6_cntr.dat"    u ($1/ngrid*(amax-amin)+amin):(sin(imax-$2/ngrid*(imax-imin))) title "2g-g5-g6"    w lines,\
  "../../secres/ai/2g_s_2g5_s7_cntr.dat" u ($1/ngrid*(amax-amin)+amin):(sin(imax-$2/ngrid*(imax-imin))) title "2g+s-2g5-s7" w lines


   "<./v_gauss/genvel_ellip2 300 115 -1 | ./v_gauss/v_gauss 2.77092 0.281258 170.0 70.0"                    u (a+$1):(sini+$3) not w l lt 2 lc 8 lw 2.0,\
   "<./v_gauss/genvel_ellip2 300 115 -1 | ./v_gauss/v_gauss 2.77092 0.281258 170.0 80.0"                    u (a+$1):(sini+$3) not w l lt 2 lc 9 lw 0.5,\
   "<./v_gauss/genvel_ellip2 300 115 -1 | ./v_gauss/v_gauss 2.77092 0.281258 170.0 90.0 | awk '(FNR<=150)'" u (a+$1):(sini+$3) not w l lt 2 lc 9 lw 0.5,\
   "family.label" u 36:38:34 w labels center,\
   "../families.syn" u 36:38:34 w labels center

