#!/usr/bin/gnuplot

load "durda.tmp3"

set term png small
set out sprintf("png/%08d_%s.png", int(chi2), out)

set xl "D [km]"
set yl "N(>D)"

set xr [0.1:1000]
set yr [0.8:1e4]

set logscale xy

set label sprintf("D_PB = %.2f\nLR_PB = %.5f\nLF_PB = %.5f\nv_esc = %.2f\nchi2 = %.2f", D_PB, LR_PB, LF_PB, v_esc, chi2) at graph 0.1, graph 0.15

p "family.dat_hc" u 1:2 t "observed family" w l lt 9,\
  filename u ($1*D_PB/100.):2 t filename w lp pt 1 lt 3,\
  "durda.tmp1" u 1:2 t "chi^2" w l lt 1 lw 3,\
  "durda.tmp2" u 1:2:3 t "sigma" w err lt 8 ps 0


