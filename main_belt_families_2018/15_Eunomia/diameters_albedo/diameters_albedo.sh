#!/bin/bash

./D.py

./mean_sigma.awk A_ifknown.dat > A.dat_mean
./median_range.awk A_ifknown.dat > A.dat_median

./hist6 100 0 1 A_ifknown.dat > A.dat_h
./A.plt

awk '!/^#/ && (NF > 0)' < family.list > tmp1
paste A.dat D.dat tmp1 > family.list_AD


