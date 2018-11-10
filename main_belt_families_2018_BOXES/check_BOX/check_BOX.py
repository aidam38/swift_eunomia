#!/usr/bin/env python2.7

import sys

if (len(sys.argv) != 2) and (len(sys.argv) != 5):
    print "Usage: check_BOX.py  DESIGNATION  [ da de dsinI ]\n"
    sys.exit(1)

dsg_to_search = sys.argv[1]
if len(sys.argv) == 2:
    da = 0.1
    de = 0.05
    dsinI = 0.05
else:
    da = float(sys.argv[2])
    de = float(sys.argv[3])
    dsinI = float(sys.argv[4])

fin = open("astorb_astdys_wise_akari_sloan.dat_WITH_PROPER_ELMTS", "r")

found = False
line = fin.readline()
while line and (not found):
    l = line.split()
    dsg = l[33]
    if dsg == dsg_to_search:
        a_c = float(l[35])
        e_c = float(l[36])
        sinI_c = float(l[37])
        found = True
        print "Designation '" + dsg_to_search + "' found."
        print "a_c = " + str(a_c) + " AU"
        print "e_c = " + str(e_c)
        print "sinI_c = " + str(sinI_c)

        fout = open("check_BOX.lab", "w")
        fout.write(line)
        fout.close()

        fout = open("check_BOX.rng", "w")
        fout.write("a1 = %f\na2 = %f\ne1 = %f\ne2 = %f\nsinI1 = %f\nsinI2 = %f\n" % (a_c-da, a_c+da, e_c-de, e_c+de, sinI_c-dsinI, sinI_c+dsinI) )
        fout.close()

    line = fin.readline()

fin.close()

if not found:
    print "Error: Designation = '" + dsg_to_search + "' not found."
    sys.exit(1)

fin = open("astorb_astdys_wise_akari_sloan.dat_WITH_PROPER_ELMTS", "r")
fout = open("check_BOX.dat", "w")

for line in fin:
    l = line.split()
    num = l[33]
    a = float(l[35])
    e = float(l[36])
    sinI = float(l[37])

    if (abs(a-a_c) < da) and (abs(e-e_c) < de) and (abs(sinI-sinI_c) < dsinI):
         fout.write(line)

fin.close()
fout.close()


