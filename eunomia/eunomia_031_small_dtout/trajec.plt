#!/bin/gnuplot

set term png small

set xl 'x [AU]'
set yl 'y [AU]'
set zl 'z [AU]'

set view equal xyz
set size square

set xyplane at 0
set key samplen 0.5 font "Helvetica,12"

set xr [-4:4]
set yr [-4:4]
set zr [-0.7:0.7]

do for [ii=1:1000] {
	set out sprintf("png/trajec_%03.0f.png", ii)
	#set out sprintf("ahoj.png")
	splot 'xyz' every ::((ii-1)*20+1)::ii*20 not w p pt 7 ps 0.7, \
}

q
'xyz' every ::1::ii*20 w l lt 1, \
