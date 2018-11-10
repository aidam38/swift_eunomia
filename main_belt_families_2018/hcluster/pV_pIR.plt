#!/usr/bin/gnuplot

set colors classic
#set term x11

set xl "{/Helvetica-Oblique p}_{V}"
set yl "{/Helvetica-Oblique p}_{IR}"

tmp=1.0
set xr [0:tmp]
set yr [0:tmp]
set size ratio -1

set zeroaxis
set ticslevel 0
set pm3d map
set nokey

load "COLOR_wise.plt"

f_(D) = 0.5 + (log10(D)-0.)/(3.-0.)*3.0

p "family.list"     u 57:59:(f_($47)):(pV_pIR($57, $59)) with p pt 7 ps var lc rgb variable,\
  "interlopers.out" u 57:59 w p pt 6 lt 2 ps 1,\
  "family.label"    u 57:59:34 w labels center
pa -1

set term post eps enh color solid "Helvetica" 18
set out "pV_pIR.eps"
rep

q


