#!/usr/bin/gnuplot

tmp=0.2
r1=-tmp
r2=tmp
g1=-tmp
g2=tmp
b1=-tmp
b2=tmp

f(x,x1,x2) = x < x1 ? 0 : ( x > x2 ? 1 : ( (x-x1)/(x2-x1) ) )
rgb(r,g,b) = int(255*f(r,r1,r2))*65536 + int(255*f(g,g1,g2))*256 + int(255*f(b,b1,b2))

aiz(a,iz) = rgb(a, -0.1-iz, -a)

