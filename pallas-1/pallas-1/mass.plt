#!/usr/bin/gnuplot

km = 1.e3  # m
MS = 1.99e30  # kg
GMS = 2.9591397914149967E-04

rho = 2860.  # kg/m^3
R = 513*km/2.  # m

M = 4./3.*pi*R**3 * rho
GM = M/MS*GMS

print "\n(2) Pallas:"
print "M = ", M, " kg"
print "GM = ", GM


