#!/usr/bin/env python

import re

f = open("89_Julia_family.list_80_srt", "r")

dsg = []
H = []

for line in f.readlines():
    if len(line) > 1 and not re.match("^#.*", line,):
        l = line.split()
        dsg.append(l[0])
        H.append(l[3])

f.close()

f = open("tex.out", "w")
f.write("""
\\begin{tabular}{lll}
dsg & $H$ [mag]\\\\
""")

for i in xrange(0,len(dsg)):
    f.write("%s & %s\\\\\n" % (dsg[i], H[i]))

f.write("""
\end{tabular}
""")

f.close()


