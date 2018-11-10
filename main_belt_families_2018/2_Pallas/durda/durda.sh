#!/bin/sh

mkdir png
rm png/*.png

./durda.py sfd/*.sfd | sort -n > durda.out

qiv png/*.png

