#!/usr/bin/awk -f

BEGIN{
  pi=3.1415926535;

  YARKO="yarko.in";
  SPIN="spin.in";
  i=0;
}
!/^#/{
  i++;
  r[i] = $1 * 1000.;	# m, radius (NOT diameter)
}
END{
  NTP=i;
  clone=1;
  print clone*NTP;
  print clone*NTP >YARKO;
  print clone*NTP"\n-1\n1" >SPIN;

  srand(-1);

  for (i=1; i<=NTP; i++) {

    for (j=1; j<=clone; j++) {

      printf("%10.2f 2860.0 1500.0 0.0010  680.0 0.10 0.90\n", r[i]) >YARKO;

      s1 = 2.*pi*rand();
      sins2 = 2.*rand()-1.;
      coss2 = sqrt(1.-sins2**2);
      sx = cos(s1)*coss2;
      sy = sin(s1)*coss2;
      sz = sins2;

      p=2.+10.*rand();	# h, rotation period
      omega = 2.*pi/(p*3600.)

      printf("%12.8f %12.8f %12.8f %15.8e\n", sx,sy,sz, omega) >SPIN;
    }
  }
}

