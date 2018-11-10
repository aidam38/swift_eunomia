#!/usr/bin/gnuplot

# resonances_cntr.plt
# Calculate contours = borders of secular resonances.
# Miroslav Broz (miroslav.broz@email.cz), Mar 23rd 2009

# set the range of secular frequencies HERE (in arcsec/yr)
set cntrparam levels discrete -0.5,0.5

set nosurface
set view 0,0
set contour base
set nokey
set table

set out "d10_cntr.dat"
splot "d10.dat" matrix

set out "d13_cntr.dat"
splot "d13.dat" matrix

set out "d46_cntr.dat"
splot "d46.dat" matrix

set out "d2_cntr.dat"
splot "d2.dat" matrix

set out "z2_cntr.dat"
splot "z2.dat" matrix

set out "z3_cntr.dat"
splot "z3.dat" matrix

set out "d61_cntr.dat"
splot "d61.dat" matrix

set out "g_s_g5_s6_cntr.dat"
splot "g_s_g5_s6.dat" matrix

set out "2g_g5_g6_cntr.dat"
splot "2g_g5_g6.dat" matrix

set out "2g_s_2g5_s7_cntr.dat"
splot "2g_s_2g5_s7.dat" matrix


