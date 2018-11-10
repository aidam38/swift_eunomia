#!/usr/bin/gawk -f

BEGIN{
  n=0;
  OFMT="%.8e";
  st=0; stt=0;
  a0=0; sa=0; saa=0; sta=0;
  n=0;
}  
!/^#/{
  n++;
  t=$1; st=st+t; stt=stt+t*t;
  a=$2; sa=sa+a; saa=saa+a*a; sta=sta+t*a;
}
END{
  da=(n*sta-st*sa)/(n*stt-st*st);
  a0=(sa-da*st)/n;
#  da = sa/st;
  Ra=(n*sta-st*sa)/sqrt((n*stt-st*st)*(n*saa-sa*sa));
  print a0,da,Ra;
}

