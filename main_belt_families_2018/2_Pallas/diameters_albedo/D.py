#!/usr/bin/env python

import subprocess
import math
from config import *

def pV_func(H,D):
    return 10.**(6.259 - 2.*math.log10(D) - 0.4*H)

def D_func(H,pV):
    return 10.**(0.5 * (6.259 - math.log10(pV) - 0.4*H))

# input

fin = open("family.list", "r")
albedo = open("A.dat", "w")
known = open("A_ifknown.dat", "w")
diameter = open("D.dat", "w")

pV_from_config = pV

for line in fin:
    if len(line) > 1 and line[0:1] != "#":
        l = line.split()
        a_astorb = l[22]
        a_astdys = l[35]
        H_wise = l[47-1]
        pV_wise = l[57-1]
        D_wise = l[55-1]
        pV_akari = l[73-1]
        D_akari = l[71-1]
        H_astorb = float(l[3])
        D_iras = l[6]

        if D_wise != "?":
            D = D_wise
            pV = pV_wise
        elif D_akari != "?":
            D = D_akari
            pV = pV_akari
        elif D_iras != "?":
            D = D_iras
            pV = pV_func(H_astorb,float(D_iras))
        else:
            try:
                pV = float(pV_from_config)
            except:
                if a_astdys != "?":
                    a = float(a_astdys)
                else:
                    a = float(a_astorb)
                if (a < 2.8):
                    pV = 0.15
                else:
                    pV = 0.05

            D = D_func(H_astorb,pV)

        albedo.write("%6.3f\n" % float(pV))
        diameter.write("%8.3f\n" % float(D))
        if D_wise != "?" or D_akari != "?" or D_iras != "?":
            known.write("%6.3f\n" % float(pV))

fin.close()
albedo.close()
diameter.close()
known.close()


