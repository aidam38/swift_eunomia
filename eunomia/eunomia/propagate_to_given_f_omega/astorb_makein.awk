#!/usr/bin/awk -f

# Convert astorb.dat to makein input format
# (=> tp.in and pl.in for numerical integrators).
# Miroslav Broz (miroslav.broz@email.cz), Mar 12th 2003

BEGIN{
  n=0;
  TMP="astorb_makein.tmp";
}
!/^#/{
  if (n==0) {
    od=substr($0,107,8);
    year=substr(od,1,4);
    month=substr(od,5,2);
    day=substr(od,7,2);
    CMD = "jdate.pl jd " year " " month " " day;
    CMD | getline jd;
  }
  n++;
  a=substr($0,169,13);
  e=substr($0,159,10);
  i=substr($0,149,10);
  peri=substr($0,127,10);
  node=substr($0,138,10);
  m=substr($0,115,10);
  print a " " e " " i " " peri " " node " " m > TMP;
}
END{
  fflush("");

  print jd "\n11\nT\n(6(1x,e22.16))\n" n;
  system("cat " TMP);
  system("rm " TMP);
}

