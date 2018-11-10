#!/bin/sh

xvpl2el < pl.in > pl.elmts
xvtp2el < tp.in > tp.elmts

./swift_bs_f_omega < swift_bs_f_omega.in

xvpl2el < dump_pl.dat > dump_pl.elmts
xvtp2el < dump_tp.dat > dump_tp.elmts

tail -1 tp.elmts
tail -1 dump_tp.elmts

follow2 bin.dat follow.out 1

./Mt.plt
./omegat.plt

