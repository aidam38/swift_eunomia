#!/bin/bash

. config.sh

for FILE in family ; do
  cp D.dat $FILE.dat_D
  sort -nr < $FILE.dat_D > $FILE.dat_sort
  ./hist_cumulative.awk < $FILE.dat_sort > $FILE.dat_hc

  eval MIN=\$"$FILE"_min
  eval MAX=\$"$FILE"_max
  awk 'BEGIN{d1=ARGV[1]; d2=ARGV[2]; ARGV[1]=ARGV[2]="";}($1>d1) && ($1<d2) && ($2>1){print;}' $MIN $MAX < $FILE.dat_hc > $FILE.dat_fit
  echo -e "$MIN 0\n$MIN 1\n\n$MAX 0\n$MAX 1" > $FILE.dat_rng
  ./loglog.awk < $FILE.dat_fit > $FILE.dat_log
  ./linreg.awk < $FILE.dat_log > $FILE.lsm
  awk 'BEGIN{f=ARGV[1]; ARGV[1]=""}{print "f_" f "(x) = (10**" $1 ") * x**(" $2 ")";}' $FILE < $FILE.lsm > $FILE.plt
  awk 'BEGIN{f=ARGV[1]; ARGV[1]=""}{print "set label \" {/=12{/Symbol -}" sprintf("%.1f", -$2) "\" at 21, f_" f "(20)";}' $FILE < $FILE.lsm >> $FILE.plt
  awk 'BEGIN{f=ARGV[1]; ARGV[1]=""}{print f " " $2}' $FILE < $FILE.lsm
done

./size_distribution.plt

exit




