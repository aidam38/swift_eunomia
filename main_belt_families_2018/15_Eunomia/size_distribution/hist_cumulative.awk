#!/usr/bin/gawk -f

BEGIN{
  n = 0;
  nd = 0;
  lastd = 0;

  LAST=ARGV[1]+0; ARGV[1]="";
}
{
  d = $1;
  n++;
}
(NR == 1) {
  print d, 0;
  lastd = d;
}
(d != lastd) {
  print lastd, n-1;
  lastd = d;
}
END{
  print d, n;
  print LAST, n;
}

