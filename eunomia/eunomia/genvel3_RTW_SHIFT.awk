#!/usr/bin/awk -f

# genvel3_RTW_SHIFT.awk
# Generate velocity field.
# Miroslav Broz (miroslav.broz@email.cz)

BEGIN{
  AU=149597870.e3;
  km=1.e3;
  ms_auday=86400./AU;

  v_R_koef = ARGV[1];
  v_T_koef = ARGV[2];
  v_W_koef = ARGV[3];
  v_R_shift = ARGV[4];
  v_T_shift = ARGV[5];
  v_W_shift = ARGV[6];

  R_shift = 0.0;
  T_shift = 0.0;
  W_shift = -1000.*km/AU;

  ARGV[1]=ARGV[2]=ARGV[3]=ARGV[4]=ARGV[5]=ARGV[6]="";

  OFMT=CONVFMT="%19.16E";
}
(FILENAME==ARGV[7]) && (NF>=3) && !/^#/{
  i++;
#  if (i==1) {
#    v_R[i]=($1*v_R_koef)*ms_auday;
#    v_T[i]=($2*v_T_koef)*ms_auday;
#    v_W[i]=($3*v_W_koef)*ms_auday;
#  } else {
    v_R[i]=($1*v_R_koef + v_R_shift)*ms_auday;
    v_T[i]=($2*v_T_koef + v_T_shift)*ms_auday;
    v_W[i]=($3*v_W_koef + v_W_shift)*ms_auday;
#  }
}
(FILENAME==ARGV[8]) && !/^#/{
  j++;
  s[j]=$0;
}
END{
  n=i;
  m=j;

# no planets here
  N=0;
  for (j=1; j<=N; j++) {
    print s[j];
  }

  print n;
#  print n-1;
  split(s[N+2],R);
  split(s[N+3],V);

  normalize(R,n_R);
  cross_product(R,V,W);
  normalize(W,n_W)
  cross_product(n_W,n_R,n_T);

# BEWARE!!! There was 2 instead of 1, because Julia was considered as massive body.
  for (i=1; i<=n; i++) {
#    print s[N+2];
    print " "  R[1] + R_shift*n_R[1] + T_shift*n_T[1] + W_shift*n_W[1],
               R[2] + R_shift*n_R[2] + T_shift*n_T[2] + W_shift*n_W[2],
               R[3] + R_shift*n_R[3] + T_shift*n_T[3] + W_shift*n_W[3];
#    print s[N+3];	# dbg
    print " "  V[1] + v_R[i]*n_R[1] + v_T[i]*n_T[1] + v_W[i]*n_W[1],
               V[2] + v_R[i]*n_R[2] + v_T[i]*n_T[2] + v_W[i]*n_W[2],
               V[3] + v_R[i]*n_R[3] + v_T[i]*n_T[3] + v_W[i]*n_W[3];
    print "0";
    print "0.0";
  }
}


func normalize(r,n) {
  norm = sqrt(r[1]**2 + r[2]**2 + r[3]**2);
  n[1] = r[1]/norm;
  n[2] = r[2]/norm;
  n[3] = r[3]/norm;
  return;
}

func cross_product(a,b,c) {
  c[1] = a[2]*b[3]-a[3]*b[2];
  c[2] = a[3]*b[1]-a[1]*b[3];
  c[3] = a[1]*b[2]-a[2]*b[1];
  return;
}


