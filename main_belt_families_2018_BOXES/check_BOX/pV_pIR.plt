#!/usr/bin/gnuplot

#set term x11

set xl "{/Helvetica-Oblique p}_{V}"
set yl "{/Helvetica-Oblique p}_{IR}" offset 1,0

#tmp=0.7
set xr [0:]
set yr [0:]
set size ratio -1

set zeroaxis
set ticslevel 0
set nokey

load "COLOR_wise.plt"

p "check_BOX.dat"     u 57:59:(pV_pIR($57,$59)) with p pt 7 ps 0.7 lc rgb variable,\
  "check_BOX.lab"     u 57:59:34 w labels center font "Helvetica,10" 
pa -1

set lmargin 6.0
set rmargin 0.8
set bmargin 3.1
set tmargin 0.5

set term post eps enh color solid "Helvetica" 18 
set out "pV_pIR.eps"
set size 0.45,0.6
rep

q


