#!/bin/sh

awk '
!/^#/ && (NF>89) && ($89 != "?"){
  astar_ = $89;
  iz_ = $85-$87;
  print astar_, iz_;

  i++;
  astar = astar + astar_;
  iz = iz + iz_;
}
END{
  astar = astar/i;
  iz = iz/i;
  print "i = ", i
  print "astar = ", astar;
  print "iz = ", iz;
}
' < 89_Julia_family.list_80 > astar_iz.txt


