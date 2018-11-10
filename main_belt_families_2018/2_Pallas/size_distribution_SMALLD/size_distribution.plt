#!/usr/bin/gnuplot

# Miroslav Broz (miroslav.broz@email.cz), Jul 26th 2002

set colors classic
set term x11

set tit ""
set xl "diameter {/Helvetica-Oblique D} / km"
set yl "number of asteroids {/Helvetica-Oblique N} (>{/Helvetica-Oblique D})" offset +1

set xr [0.5:700]
miny=0.8
maxy=50000
set yr [miny:maxy]
set logscale xy

set style line 1 lt 9 lw 0.5 # fit
set style line 3 lt 7 lw 3   # Eurybates
set style line 5 lt 9 lw 0.5 # ranges

set mytics 10

load "family.plt"

p f_family(x)          not            ls 1,\
  "family.dat_hc"      t "family" w l ls 3,\
  "family.dat_rng"     u 1:(miny+$2*(maxy-miny)) not w l ls 5
pa -1

set term postscript eps enh color solid "Helvetica" 18
set out "size_distribution.eps"
set size 0.75,1
rep

q

f_family1(x) = (10**1.95918241e+00) * x**(-3.9-0.2)
f_family2(x) = (10**1.95918241e+00) * x**(-3.9+0.2)

  f_family1(x)          not            ls 1,\
  f_family2(x)          not            ls 1,\

