#!/bin/bash

# secres.sh
# Call secre8, secres programs and gnuplot scripts.
# Miroslav Broz (miroslav.broz@email.cz), Mar 23rd 2009

if [ "$1" = "" ]; then
  echo "Usage: secres.sh [NGRID] [amin] [amax] [ecc] [inc], numbers in %.3f"
  exit 1
fi

NGRID=$1
AMIN=$2
AMAX=$3
ECC=$4
INC=$5

EMIN=0
EMAX=0.5
IMIN=0
IMAX=40

echo -e "ngrid=$NGRID\namin=$AMIN\namax=$AMAX\nemin=$EMIN\nemax=$EMAX\nimin=$IMIN\nimax=$IMAX" > ranges.plt

echo -e "     $NGRID\n       2\n    "$AMIN"0    "$AMAX"0\n    "$ECC"0    "$ECC"0\n    $IMIN   $IMAX\n  90.0000  90.0000\n" > secre8.opt
./secre8
./secres
gnuplot resonances_cntr.plt
mv *_cntr.dat ai/
./resonances_ai.plt

echo -e "     $NGRID\n       3\n    "$AMIN"0    "$AMAX"0\n    $EMIN    $EMAX\n   "$INC"00   "$INC"00\n  90.0000  90.0000\n" > secre8.opt
./secre8
./secres
gnuplot resonances_cntr.plt
mv *_cntr.dat ae/
./resonances_ae.plt


