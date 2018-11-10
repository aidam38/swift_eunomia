#!/bin/bash

. config.sh

./D_complete.awk $D_complete  D.dat > D_complete.out

awk '{ print "a=" $2; print "b=" $1; }' < family.lsm >> D_complete.plt

./parent_body_volume_D_complete.plt 2> parent_body_volume_D_complete.out


