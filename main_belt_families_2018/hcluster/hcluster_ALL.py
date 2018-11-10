#!/usr/bin/env python

import sys
import subprocess

from config import *

for v_cutoff in range(v1,v2+dv,dv):
    
    cmd = "../hcluster4/hcluster4 %s %f %f %s" % (designation, v_cutoff, H_limit, catalogue) 
    print cmd
    out = subprocess.check_output(cmd, shell=True)

    fout = open("family.list_" + str(v_cutoff), "w")
    fout.write(out)
    fout.close()


