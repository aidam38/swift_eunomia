#!/bin/gnuplot

set encoding utf8 

set xl 't [Myr]'
set yl 'a [AU]'

#"<awk '$1==11{print $2, $3}' bin.proper.out" using 1:2-0.43275005865 w lp lc rgb "#151515", \

plot	"<awk '$1==5{print $2, $3}' bin.filter.out" w lp lc rgb "#000000" title "Stredni elementy", \
	"<awk '$1==5{print $2, $3}' bin.out" w lp lc rgb "#303030" title "Oskulacni elementy"
pause -1

set term post eps enh color solid "Helvetica" 18
set out "atOF.eps"
rep
