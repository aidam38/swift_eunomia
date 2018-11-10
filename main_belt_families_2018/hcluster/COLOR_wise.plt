#!/usr/bin/gnuplot

r1=0.
r2=0.5
g1=0.1
g2=0.4
b1=0.9
b2=1.0

f(x,x1,x2) = x < x1 ? 0 : ( x > x2 ? 1 : ( (x-x1)/(x2-x1) ) )
rgb(r,g,b) = int(255*f(r,r1,r2))*65536 + int(255*f(g,g1,g2))*256 + int(255*f(b,b1,b2))

pV_pIR(pV, pIR) = rgb(pIR, pV, 1.-pV)

