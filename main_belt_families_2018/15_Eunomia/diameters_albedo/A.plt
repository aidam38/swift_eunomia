#!/usr/bin/gnuplot

set xl "albedo A"
set yl "number of asteroids N"

set xr [0:1.0]

p "A.dat_h" u 1:3 w histeps
pa -1

set term png small
set out "A.png"
rep

