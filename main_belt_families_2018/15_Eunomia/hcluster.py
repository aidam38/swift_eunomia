#!/usr/bin/env python2.7

import sys
import subprocess
from config import *

# call hcluster

cmd = "./hcluster4 %s %f %f %s" % (designation, v_cutoff, H_limit, catalogue) 
print cmd
out = subprocess.check_output(cmd, shell=True)

fout = open("family.list", "w")
fout.write(out + "\n")
fout.close()

# first body

fout = open("family.label", "w")
for line in out.split("\n"):
    if line[0:1] != "#" and len(line) > 0:
        fout.write(line + "\n")
        fout.close()
        break

# gnuplot ranges

a = []
e = []
i = []
H = []
for line in out.split("\n"):
    if line[0:1] != "#" and len(line) > 0:
        l = line.split()
        a.append(float(l[35]))
        e.append(float(l[36]))
        i.append(float(l[37]))
        H.append(float(l[34]))

fout = open("family.rng", "w")
fout.write("a1 = " + str(min(a)) + "\n")
fout.write("a2 = " + str(max(a)) + "\n")
fout.write("e1 = " + str(min(e)) + "\n")
fout.write("e2 = " + str(max(e)) + "\n")
fout.write("i1 = " + str(min(i)) + "\n")
fout.write("i2 = " + str(max(i)) + "\n")
fout.write("H1 = " + str(min(H)) + "\n")
fout.write("H2 = " + str(max(H)) + "\n")
if a_c == None:
    a_c = a[0]
fout.write("a_c = " + str(a_c) + "\n")
if C != None:
    fout.write("C = " + str(C) + "\n")
fout.close()


