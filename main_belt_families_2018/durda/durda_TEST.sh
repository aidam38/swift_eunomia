#!/bin/sh

mkdir png
rm png/*.png

./durda.py *.sfd | sort -n > durda.out

qiv png/*.png


