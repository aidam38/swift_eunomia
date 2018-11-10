#!/usr/bin/gnuplot

set term x11

set xl "R [m]"
set yl "da/dt [AU/Myr]"

set zeroaxis

p "yarko_dadt.out" u 4:9
pa -1

set term post eps enh solid color
set out "yarko_dadt.eps"
rep

