#!/usr/bin/env python

import sys
from config import *

GAUSS = 0.01720209895
GM = GAUSS*GAUSS*365.25*365.25	# UNITS: JULIAN YEARS, AU, SUN MASS
AU = 1.49597870e11		# IN METERS
FACTOR = AU/365.25/86400.	# CONVERSION FACTOR FROM AU/YR TO M/S
SQRFAC = FACTOR**2

def d1_sq(a1,e1,i1,a2,e2,i2):
    return 2. * GM/(a1+a2) * SQRFAC * (1.25 * (2.00*(a2-a1)/(a2+a1))**2 + 2.00 * (e2-e1)**2 + 2.00 * (i2-i1)**2)

a1 = []
e1 = []
i1 = []
comment = ""
f = open("family.list", "r")
for line in f:
    if len(line) > 1 and line[0:1] == "#":
        comment += line
    elif len(line) > 1 and line[0:1] != "#":
        l = line.split()
        a1.append(float(l[35])) 
        e1.append(float(l[36])) 
        i1.append(float(l[37])) 
f.close()

v2 = float(v_halo)**2

comment += "\n# catalogue_halo = %s\n# v_halo = %s m/s\n" % (catalogue_halo, v_halo)

f = open(catalogue_halo, "r")
fout = open("halo.list", "w")
fout.write(comment + "\n")

for line in f:
    l = line.split()
    a2 = float(l[35])
    e2 = float(l[36])
    i2 = float(l[37])
    for j in range(0,len(a1)):
        if d1_sq(a1[j],e1[j],i1[j],a2,e2,i2) <= v2:
            fout.write(line)
            break
f.close()
fout.close()


