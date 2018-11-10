#!/usr/bin/gnuplot

set xl 'a_p [AU]'
set yl 'i_p'
plot 'family.list' using 36:38 
pause -1

set term post eps color
set out 'ai.eps'
replot
