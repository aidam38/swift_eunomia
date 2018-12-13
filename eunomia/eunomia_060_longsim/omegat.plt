#!/bin/gnuplot

set xl 't [Myr]'
set yl 'i [deg]'

#plot 'tp1_hista.dat' w l lc rgb "#151515"
plot "<awk '$1==1{print $2, $6}' bin.out" w lp lc rgb "#151515"
pause -1

set term post eps enh color solid "Helvetica" 18
set out "it.eps"
rep
