#!/usr/bin/gawk -f

# median_range.awk
# Calculate meadian and range values for a simple 1-column data file.
# Miroslav Broz (mira@sirrah.troja.mff.cuni.cz), Oct 11th 2004

BEGIN{

  i=0;
  OFMT="% 16.10f";
  CONVFMT="% 16.10f";
}
!/^#/{
  i++;
  m[i]=$1;
}
END{
  n=i;
# sort m[] array
  for (j=1; j<=n; j++) {
    min=j;
    for (k=j+1; k<=n; k++) {
      if (m[min] > m[k]) {
        min=k;
      }
    }
    tmp=m[j];
    m[j]=m[min];
    m[min]=tmp;
  }
# get median
  n2=floor(n/2);
  if ((n%2) == 0) {
    med=(m[n2]+m[n2+1])/2;
  } else {
    med=m[n2+1];
  }
  sig=m[n]-m[1];
  printf ("%16.10f %16.10f\n",med,sig);
}

function floor(x) {
  return (x - (x % 1));
}


