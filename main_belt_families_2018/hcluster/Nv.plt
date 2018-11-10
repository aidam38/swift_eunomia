#!/usr/bin/gnuplot

#set term x11

set xl "cut-off velocity v (km/s)"
set yl "number of family members"

set yr [0:]

p "Nv.dat" w lp
pa -1

set term png small
set out "Nv.png"
rep

