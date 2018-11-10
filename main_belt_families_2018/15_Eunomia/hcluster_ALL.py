#!/usr/bin/env python2.7

import sys
import subprocess

from config import *

if v1 < 10:
   v = range(v1,10,1) + range(10,v2+dv,dv)
else:
   v = range(v1,v2+dv,dv)

for v_cutoff in v:
    
    cmd = "./hcluster4 %s %f %f %s" % (designation, v_cutoff, H_limit, catalogue) 
    print cmd
    try:
        out = subprocess.check_output(cmd, shell=True)
    except:
        sys.exit(1)

    fout = open("family.list_%03d" % (v_cutoff), "w")
    fout.write(out)
    fout.close()


