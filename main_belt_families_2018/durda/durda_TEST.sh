#!/bin/sh

mkdir png
rm png/*.png

./durda.py *.sfd | sort -n > durda.out

sxiv png/*.png


