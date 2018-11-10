#!/usr/bin/gnuplot

# resonances_ae.plt
# Plot (a,e) for ALL secular resonances.
# Miroslav Broz (miroslav.broz@email.cz), Mar 23rd 2009

load "ranges.plt"

set xr [amin:amax]
set yr [emin:emax]

set title "secular resonances by Milani and Knezevic (1997)"
set xlabel "semimajor axis a [AU]"
set ylabel "eccentricity e []"

set term x11
set out
p "ae/d10_cntr.dat" u ($1/ngrid*(amax-amin)+amin):(emax-$2/ngrid*(emax-emin)) title "g+s-g6-s6" w l,\
  "ae/d13_cntr.dat" u ($1/ngrid*(amax-amin)+amin):(emax-$2/ngrid*(emax-emin)) title "g-2g6+g5" w l,\
  "ae/d46_cntr.dat" u ($1/ngrid*(amax-amin)+amin):(emax-$2/ngrid*(emax-emin)) title "s-s6-g5+g6" w l,\
  "ae/d2_cntr.dat" u ($1/ngrid*(amax-amin)+amin):(emax-$2/ngrid*(emax-emin)) title "nu6" w l,\
  "ae/z2_cntr.dat" u ($1/ngrid*(amax-amin)+amin):(emax-$2/ngrid*(emax-emin)) title "z2" w l,\
  "ae/z3_cntr.dat" u ($1/ngrid*(amax-amin)+amin):(emax-$2/ngrid*(emax-emin)) title "z3" w l,\
  "ae/d61_cntr.dat" u ($1/ngrid*(amax-amin)+amin):(emax-$2/ngrid*(emax-emin)) title "g-3g6+2g5" w l,\
  "ae/g_s_g5_s6_cntr.dat" u ($1/ngrid*(amax-amin)+amin):(emax-$2/ngrid*(emax-emin)) title "g+s-g5-s6" w l,\
  "ae/2g_g5_g6_cntr.dat" u ($1/ngrid*(amax-amin)+amin):(emax-$2/ngrid*(emax-emin)) title "2g-g5-g6" w l,\
  "ae/2g_s_2g5_s7_cntr.dat" u ($1/ngrid*(amax-amin)+amin):(emax-$2/ngrid*(emax-emin)) title "2g+s-2g5-s7" w l
pause -1

set term postscript eps color 15
set out "resonances_ae.eps"
rep


