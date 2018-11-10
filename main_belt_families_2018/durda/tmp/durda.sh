#!/bin/sh

mkdir png
rm png/*.png

./durda.py ../../durda/*.sfd | sort -n > durda.out

qiv png/*.png

