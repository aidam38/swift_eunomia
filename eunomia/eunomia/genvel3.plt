#!/usr/bin/gnuplot

#set term x11

set xl "ejection velocity  v / m/s"
set yl "N"

p "genvel3.out_v_h" u 1:3 w histeps

pa -1

set term png small
set out "genvel3.png"
rep


