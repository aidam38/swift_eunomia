#!/usr/bin/gnuplot

#set term x11

set xl "a_p [AU]"
set yl "e_p"
set zl "sin I_p"

set ticslevel 0
set key
set view 90,0

f_(H) = 2.*(0.1 + (H-17.)/(6.-17.)*1.5)

sp \
   "family.list_046" u 36:37:38 w p t " 46",\
   "family.list_045" u 36:37:38 w p t " 45",\
   "family.list_044" u 36:37:38 w p t " 44",\
   "family.list_043" u 36:37:38 w p t " 43",\
#   "family.list_042" u 36:37:38 w p t " 42",\
#   "family.list_041" u 36:37:38 w p t " 41",\
#   "family.list_040" u 36:37:38 w p t " 40",\
#   "family.list_047" u 36:37:38 w p t " 47",\
#   "family.list_048" u 36:37:38 w p t " 48",\
#   "family.list_049" u 36:37:38 w p t " 49",\
#   "family.list_050" u 36:37:38 w p t " 50",\
   "family.label" u 36:37:38:34 w labels center not
pa -1

set term post eps enh color solid "Helvetica" 18
set out "aei.eps"
rep


