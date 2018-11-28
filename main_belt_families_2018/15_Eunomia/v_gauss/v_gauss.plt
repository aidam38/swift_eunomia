#!/usr/bin/gnuplot

#set term x11

set xl "Da [AU]"
set yl "De []"
set zl "DI [deg]"

set ticslevel 0
set size 0.666,1
set view 0,0,1,1

sp './v_gauss.out' u 1:2:3 w p
pa -1
q

