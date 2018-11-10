#!/bin/sh

awk '/v_cutoff = /{ v = $4; }/n_family/{ N = $4; print v, N; }' family.list_* | sort -n > Nv.dat
../hcluster/Nv.plt


