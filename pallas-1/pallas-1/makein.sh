#!/bin/bash

# geometry of the impact disruption
F=90
OMEGA=60

v_R_koef=1.0
v_T_koef=1.0
v_W_koef=1.0
v_R_shift=0.0
v_T_shift=0.0
v_W_shift=200.0

export F OMEGA

cd propagate_to_given_f_omega
./makein.sh
cd ..

# D_astorbifexists is from elsewhere <- for a particular value of albedo (0.12)
awk '{ printf("%8.3f\n", $1/2.); }' < D.dat > R.dat
./yarko.awk < R.dat

cp propagate_to_given_f_omega/dump_pl.dat pl.in_PLANETSONLY

# write the number of asteroids from D_astorbifexists to genvel3.in!
./genvel3 < genvel3.in > genvel3.out
./genvel3_RTW_SHIFT.awk $v_R_koef $v_T_koef $v_W_koef $v_R_shift $v_T_shift $v_W_shift genvel3.out propagate_to_given_f_omega/dump_tp.dat > tp.in

xvpl2el < pl.in > pl.elmts
xvtp2el < tp.in > tp.elmts

# compute histogram of velocities:
awk '!/^#/{ print sqrt($1**2+$2**2+$4**2); }' genvel3.out > genvel3.out_v
hist6 40 0 1000 genvel3.out_v > genvel3.out_v_h

# some plots to check
./genvel3.plt
./tp.plt


