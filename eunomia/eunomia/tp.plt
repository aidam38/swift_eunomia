#!/usr/bin/gnuplot

#set term x11 

set xl "a [AU]"
set yl "e []"
set zl "sin I []"

#set xr [3.85:4.15]

set ticslevel 0
set size 0.666,1
set view 0,0,1,1
set ang deg

sp 'tp.elmts'                u 1:2:(sin($3)) w p,\
   'EUNOMIA_family.list_WO_INTERLOPERS' u 36:37:38      w p,\
   "<awk '($1==15)' EUNOMIA_family.list_WO_INTERLOPERS" u 36:37:38:1 not w labels
pa -1

set term png small
set out "tp.png"
rep

q

#   'family.list_REMOVED_OUTLIERS' u 2:3:4 w p,\
#   'family.list_40'               u 2:3:4 w p,\

