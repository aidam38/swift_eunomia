#!/bin/sh

ECC=0.100
#INCS="8.625 8.875 9.125 9.375 9.625 9.875 10.125 10.375 10.625 10.875 11.125 11.375 11.625 11.875"
INCS="10.000"

NGRID=101
AMIN=2.000
AMAX=3.300

for INC in $INCS ; do 
  ./secres.sh $NGRID $AMIN $AMAX $ECC $INC

#  echo ae_$INC
#  mkdir ae_$INC
#  mv ae/* ae_$INC/
done


