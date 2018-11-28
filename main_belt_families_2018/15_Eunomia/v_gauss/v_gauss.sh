#!/bin/sh

make
./genvel_ellip2 < genvel_ellip.in > genvel_ellip.out

./v_gauss < v_gauss.in > v_gauss.out
./v_gauss.plt

