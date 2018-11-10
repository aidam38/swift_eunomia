#!/usr/bin/env python

import os
import re
import sys
import math
import subprocess

from config import *

########################################################################

def loginterp(x,y,x0):
    n = len(x)
    if x0 < x[0]:
        extra = True
        y0 = y[0]	# adjusted extrapolation!
    elif x0 > x[n-1]:
        extra = True
        y0 = y[n-1]	# adjusted!
    else:
        extra = False
        i = 1
        while x[i] < x0:
            i = i + 1

        if (y[i] > 0.) and (y[i-1] > 0.) and (x[i] > 0.) and (x[i-1] > 0.):
            y0 = 10.0** (math.log10(y[i-1]) + (math.log10(y[i])-math.log10(y[i-1])) * (math.log10(x0)-math.log10(x[i-1]))/(math.log10(x[i])-math.log10(x[i-1])) )
        else:
            y0 = y[i-1] + (y[i]-y[i-1]) * (x0-x[i-1])/(x[i]-x[i-1])	# a linear version in case of any problems

    return (y0, extra)

########################################################################

def chi2_func(D_obs, N_obs, D, N, D_1, D_2):
    chi2 = 0.
    n_fit = 0
    f1 = open("durda.tmp1", "w")
    f2 = open("durda.tmp2", "w")
    f1.write("# x_syn & y_syn or y_obs\n")
    f2.write("# x_syn & y_obs & sigma\n")

    n = 50
    D_test = []
    for i in range(0,n):
        D_test.append(10.**(0. + 3.*i/(n-1)))	# log-scale

    for x_syn in D_test:
        (y_syn, extra) = loginterp(D, N, x_syn)
        if x_syn >= D_1 and x_syn <= D_2:
             (y_obs, extra) = loginterp(D_obs, N_obs, x_syn)

             sigma2 = 0.1**2
             chi2 = chi2 + (math.log10(y_syn)-math.log10(y_obs))**2/sigma2	# logarithms?! they seem to better correspond to manual fitting
             n_fit = n_fit + 1

             f1.write("%f %f\n%f %f\n\n" % (x_syn, y_syn, x_syn, y_obs))
             f2.write("%f %f %f\n" % (x_syn, y_obs, math.sqrt(sigma2)))

    f1.close()
    f2.close()

    return (chi2, n_fit)

########################################################################

# command-line arguments

if len(sys.argv) < 2:
    print "Usage: durda.py FILENAME_sfd"
    sys.exit(1)

files = sys.argv[1:]

# read the observed family SFD

f = open("family.dat_hc", "r")
D_obs = []
N_obs = []
for line in f:
    l = line.split()
    D_obs.append(float(l[0]))
    N_obs.append(float(l[1]))
f.close()
D_obs.reverse()
N_obs.reverse()
D_obs.pop()
N_obs.pop()
D_obs.pop(0)
N_obs.pop(0)

D_2 = 1000.	# upper limit for chi^2 computation; D_1 is in config.py

# read Durda's SFD data files

print "# chi2 & n_fit & D_PB [km] & Durda's filename (Material_velocity_angle_logtargettoprojectile)"

for filename in files:
    if os.path.isfile(filename) and re.match(".*\.sfd",filename):
        f = open(filename, "r")
        D = []
        N = []
        for line in f:
            l = line.split()
            D.append(float(l[0]))
            N.append(float(l[1]))
        f.close()
        D.reverse()
        N.reverse()

        D_PB = 100.*D_obs[-1]/D[-1]	# simple expression - NO fitting!
        D_scaled = []
        for i in range(0,len(D)):
            D_scaled.append(D[i]*D_PB/100.)

        (chi2, n_fit) = chi2_func(D_obs, N_obs, D_scaled, N, D_1, D_2)

        print "%10.2f  %3d  %8.3f  %s" % (chi2, n_fit, D_PB, filename)

        f = open("durda.tmp3", "w")
        f.write("filename = \"%s\"\nout = \"%s\"\nD_PB = %f\nchi2 = %f\n" % (filename, os.path.basename(filename), D_PB, chi2))
        f.close()

        subprocess.check_output("./durda.plt", shell=True)
#        print subprocess.check_output("./durda.plt", shell=True)
#        sys.exit(1)

#        print ""

