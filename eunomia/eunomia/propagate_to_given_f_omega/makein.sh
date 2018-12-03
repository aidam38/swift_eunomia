#!/bin/bash

# select Hilda <- this was necessary to run only once!
#awk '!/^#/ && /Hilda/' librating.astorb > Hilda.astorb
./astorb_makein.awk Eunomia.astorb > makein.src

# these three values are usually set up in ../../optimalizace.pl
#F=30
#OMEGA=60
#AJ=5.20273

# shift Hilda (correspondingly to Jupiter)
#./makein.awk -vAJ=$AJ < makein.src > makein.in
#./makeinpl.awk -vAJ=$AJ < makeinpl.src > makeinpl.in

echo -e "param.in\npl.in\ntp.in\n$F\n$OMEGA\n1\n1.e-8" > swift_bs_f_omega.in

cp makein.src makein.in		# i.e. no-migration case!

#ln -sf ~/a/tools/makein_dir/JPLEPH
makein < makein.in > makein.out
baryc2 2 3 4 5 10 < makein.out > baryc2.out
laplac < baryc2.out > laplac.out
pltp.awk < laplac.out 
xvtp2el < tp.in > tp.elmts

# makeinpl < makeinpl.in > pl.in	# only in case of migration!
xvpl2el < pl.in > pl.elmts

./swift_bs_f_omega < swift_bs_f_omega.in > swift_bs_f_omega.out

xvpl2el < dump_pl.dat > dump_pl.elmts
xvtp2el < dump_tp.dat > dump_tp.elmts

tail -1 makein.in
tail -1 tp.elmts
tail -1 dump_tp.elmts


