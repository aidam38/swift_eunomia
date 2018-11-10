#!/bin/sh

make
./genvel_const < genvel_const.in > genvel_const.out
./genvel_const.plt

