#!/bin/bash

ECC=0.281258
INCS="33.198"

NGRID=101
A=2.77092
AMIN=2.600
AMAX=2.950

for INC in $INCS ; do 
  ./secres.sh $NGRID $AMIN $AMAX $ECC $INC

#  echo ae_$INC
#  mkdir ae_$INC
#  mv ae/* ae_$INC/
done


