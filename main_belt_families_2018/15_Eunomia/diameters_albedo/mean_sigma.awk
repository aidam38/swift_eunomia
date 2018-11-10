#!/usr/bin/awk -f

# Calculate mean and sigma from 1 column data.
# Miroslav Broz, miroslav.broz@email.cz, May 16th 2001

BEGIN{
  i=0;
  sx=0.;
  OFMT="%16.10f";
}
!/^#/{
  if (length($0)>0) {
    i++;
    x[i]=$1;
    sx=sx+$1;
  }
}
END{
  n=i;
  if (n==1) {
    print x[1],0,1;
  } else if (n>=2) {
    xm=sx/n;
    sx=0.;
    for (i=1; i<=n; i++) {
      sx=sx+(x[i]-xm)**2;
    }
    xs=sqrt(sx/(n-1));

    print xm,xs,n;
  }
}

