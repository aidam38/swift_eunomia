#!/usr/bin/gnuplot

# resonances_ai.plt
# Plot (a,i) for ALL secular resonances.
# Miroslav Broz (miroslav.broz@email.cz), Mar 23rd 2009

load "ranges.plt"

set xr [amin:amax]
set yr [imin:imax]

set title "secular resonances by Milani and Knezevic (1997)"
set xlabel "semimajor axis a [AU]"
set ylabel "inclination i [deg]"

set term x11
set out
p "ai/d10_cntr.dat" u ($1/ngrid*(amax-amin)+amin):(imax-$2/ngrid*(imax-imin)) title "g+s-g6-s6" w lines,\
  "ai/d13_cntr.dat" u ($1/ngrid*(amax-amin)+amin):(imax-$2/ngrid*(imax-imin)) title "g-2g6+g5" w lines,\
  "ai/d46_cntr.dat" u ($1/ngrid*(amax-amin)+amin):(imax-$2/ngrid*(imax-imin)) title "s-s6-g5+g6" w lines,\
  "ai/d2_cntr.dat" u ($1/ngrid*(amax-amin)+amin):(imax-$2/ngrid*(imax-imin)) title "nu6" w lines,\
  "ai/z2_cntr.dat" u ($1/ngrid*(amax-amin)+amin):(imax-$2/ngrid*(imax-imin)) title "z2" w lines,\
  "ai/z3_cntr.dat" u ($1/ngrid*(amax-amin)+amin):(imax-$2/ngrid*(imax-imin)) title "z3" w lines,\
  "ai/d61_cntr.dat" u ($1/ngrid*(amax-amin)+amin):(imax-$2/ngrid*(imax-imin)) title "g-3g6+2g5" w lines,\
  "ai/g_s_g5_s6_cntr.dat" u ($1/ngrid*(amax-amin)+amin):(imax-$2/ngrid*(imax-imin)) title "g+s-g5-s6" w lines,\
  "ai/2g_g5_g6_cntr.dat" u ($1/ngrid*(amax-amin)+amin):(imax-$2/ngrid*(imax-imin)) title "2g-g5-g6" w lines,\
  "ai/2g_s_2g5_s7_cntr.dat" u ($1/ngrid*(amax-amin)+amin):(imax-$2/ngrid*(imax-imin)) title "2g+s-2g5-s7" w lines
pause -1

set term postscript eps color 15
set out "resonances_ai.eps"
rep


