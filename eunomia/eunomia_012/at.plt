#!/bin/gnuplot

set xl 't [Myr]'
set yl 'a [AU]'

#plot "<awk '$1==11{print $2, $3}' bin.out" w lp lc rgb "#505050", \

plot	"<awk '$1==11{print $2, $3}' bin.filter.out" using 1:2-0.43275005865 w lp lc rgb "#808080", \
	 "<awk '$1==11{print $2, $3}' bin.proper.out" using 1:2-0.43275005865 w lp lc rgb "#151515"
pause -1

set term post eps enh color solid "Helvetica" 18
set out "at.eps"
rep
