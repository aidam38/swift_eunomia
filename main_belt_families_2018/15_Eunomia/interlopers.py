#!/usr/bin/env python2.7

import subprocess
import os
import math

from config import *

def pV_func(H,D):
    return 10.**(6.259 - 2.*math.log10(D) - 0.4*H)

# input

s = []
i8r = []
dsg = []
a = []
H = []
sinI = []
pV = []
astar = []
iz = []

if os.path.isfile("halo.list"):
    fin = open("halo.list", "r")
else:
    fin = open("family.list", "r")

comment = ""

for line in fin:
    if len(line) > 1 and line[0:1] == "#":
        comment = comment + line
    elif len(line) > 1 and line[0:1] != "#": 
        l = line.split()
        s.append(line)
        i8r.append(0)
        dsg.append(l[33])
        H_astorb = float(l[34])
        H.append(H_astorb)
        a.append(float(l[35]))
        sinI.append(float(l[37]))

        pV_wise = l[57-1]
        pV_akari = l[73-1]
        D_iras = l[7-1]
        if pV_wise != "?":
            pV_ = float(pV_wise)
        elif pV_akari != "?":
            pV_ = float(pV_akari)
        elif D_iras != "?":
            pV_ = pV_func(H_astorb,float(D_iras))
        else:
            pV_ = None
        pV.append(pV_)

        astar_ = l[104-1]
        if astar_ != "?":
            astar_ = float(astar_)
        else:
            astar_ = None
        astar.append(astar_)

        i_ = l[100-1]
        z_ = l[102-1]
        if i_ != "?" and z_ != "?":
            iz_ = float(i_)-float(z_)
        else:
            iz_ = None
        iz.append(iz_)

fin.close()
n = len(s)

# various tests

def H_func(a,a_c,C):
    if (abs(a-a_c) < 1.e-38):
        return -1.e38
    else:
        return math.log10(abs(a-a_c)/C)/0.2

try:
    for i in range(0,n):
        if H[i] < H_func(a[i],a_c,C):
            i8r[i] += 1

    comment += "# H > log10(|a_p - %f| / %g) / 0.2\n" % (a_c, C)
except:
    print "# Warning: (a,H) test NOT done!"

try:
    for i in range(0,n):
        if sinI[i] < float(sinI_min) or sinI[i] > float(sinI_max):
            i8r[i] += 1

    comment += "# %f < sin(I_p) < %f\n" % (sinI_min, sinI_max)
except:
    print "# Warning: sin(I) test NOT done!"

try:
    for i in range(0,n):
        if pV[i] != None and (pV[i] < float(pV_min) or pV[i] > float(pV_max)):
            i8r[i] += 1

    comment += "# %f < p_V < %f\n" % (pV_min, pV_max)
except:
    print "# Warning: pV test NOT done!"

try:
    for i in range(0,n):
        if astar[i] != None and (astar[i] < float(astar_min) or astar[i] > float(astar_max)):
            i8r[i] += 1

    comment += "# %f < a^* < %f\n" % (astar_min, astar_max)
except:
    print "# Warning: a^* test NOT done!"

try:
    for i in range(0,n):
        if iz[i] != None and (iz[i] < float(iz_min) or iz[i] > float(iz_max)):
            i8r[i] += 1

    comment += "# %f < i-z < %f\n" % (iz_min, iz_max)
except:
    print "# Warning: i-z test NOT done!"

# interlopers to be removed manually

for d9n in interlopers:
    for i in range(0,n):
        if dsg[i] == d9n:
            i8r[i] += 1

for d9n in members:
    for i in range(0,n):
        if dsg[i] == d9n:
            i8r[i] = 0

n_family_wo_interlopers = 0
for i in range(0,n):
    if i8r[i] == 0:
        n_family_wo_interlopers += 1

comment += "# n_family_wo_interlopers = %d\n" % (n_family_wo_interlopers) 

# output

members = open("family.list_WO_INTERLOPERS", "w")
i9s = open("interlopers.out", "w")

print "# designation & number of tests that the asteroid did NOT passed"

members.write(comment + "\n")

for i in range(0,n):
    if i8r[i] == 0:
         members.write(s[i])
    else:
         i9s.write(s[i])
         print dsg[i] + "	" + str(i8r[i])
         print s[i]

members.close()
i9s.close()

fout = open("family.rng", "w")
#fout.write("a1 = " + str(min(a)) + "\n")
#fout.write("a2 = " + str(max(a)) + "\n")
#fout.write("e1 = " + str(min(e)) + "\n")
#fout.write("e2 = " + str(max(e)) + "\n")
#fout.write("i1 = " + str(min(i)) + "\n")
#fout.write("i2 = " + str(max(i)) + "\n")
#fout.write("H1 = " + str(min(H)) + "\n")
#fout.write("H2 = " + str(max(H)) + "\n")
if a_c == None:
    a_c = a[0]
fout.write("a_c = " + str(a_c) + "\n")
if C != None:
    fout.write("C = " + str(C) + "\n")
fout.close()


