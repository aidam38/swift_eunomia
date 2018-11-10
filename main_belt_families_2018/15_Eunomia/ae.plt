#!/usr/bin/gnuplot

set xl 'a_p [AU]'
set yl 'e_p'
plot 'family.list' using 36:37 
pause -1

set term post eps color
set out 'ae.eps'
replot
