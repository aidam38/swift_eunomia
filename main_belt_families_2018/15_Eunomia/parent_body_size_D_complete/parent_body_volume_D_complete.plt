#!/usr/bin/gnuplot

# parent_body_volume_D_complete.plt
# Miroslav Broz (miroslav.broz@email.cz), Apr 1st 2008

set colors classic
#set term x11

load "D_complete.plt"

print "V1    = ", V1, " km^3"

D_PB_gt_D_complete = (6./pi * V1)**(1./3.)

print "D_complete = ", D_complete, " km"
print "D_PB(>D_complete) = ", D_PB_gt_D_complete, " km"

D = 0.			# integruj az do NULY!
V_gt_D(D) = V1 - pi/6. * 1. * 10.**b * a/(a+3) * (D_complete**(a+3) - D**(a+3))
D_PB(D) = (6./pi * V_gt_D(D))**(1./3.)

print "V(>D) = ", V_gt_D(D), " km^3"
print "D_PB = ", D_PB(D), " km"

V_LF = pi/6.*D_LF**3
LF_PB = V_LF/V_gt_D(D)

print "D_LF = ", D_LF, " km"
print "V_LF = ", V_LF, " km^3"
print "LF/PB = ", LF_PB, " (Largest Fragment/Parent Body mass ratio)"

rho_PB = 2500.       # kg/m^3
G = 6.67e-11         # SI
pi = 3.1415926535

R_PB = D_PB(D)*1.e3/2.;
v_esc = sqrt(8./3.*pi*G*rho_PB) * R_PB;

print "v_esc = ", v_esc, " m/s = ", v_esc/1.e3, " km/s"

########################################################################

set xr [0:D_complete]
miny=90
maxy=110
set yr [miny:maxy]
set autoscale y
set samples 1000

set xl "{/Helvetica-Oblique D} / km"
set yl "{/Helvetica-Oblique D}_{PB} / km" offset 1

set label "{/Helvetica-Oblique D}_{complete}" at D_complete, miny-0.11*(maxy-miny)
set label "  {/Helvetica-Oblique D}_{PB}" at D, D_PB(D)

set style line 1 lw 5
set style line 2 lt 1 ps 2 pt 7
set nokey
set ytics 5
set mytics 5
set grid noxtics noytics front

p D_PB(x) w l ls 1,\
  "<echo \"1 1\"" u ($1*D):($2*D_PB(D)) w p ls 2
pa -1

set term post eps enh solid color "Helvetica" 18
set size 0.7,0.9
set out "parent_body_volume_D_complete.eps"
rep

