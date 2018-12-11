#!/bin/gnuplot

set xl 't [Myr]'
set yl 'a [AU]'

#plot 'tp1_hista.dat' w l lc rgb "#151515"
plot "<awk '$1==11{print $2, $3}' bin.out" w l lc rgb "#151515"
pause -1

set term post eps enh color solid "Helvetica" 18
set out "at.eps"
rep
