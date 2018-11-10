/* THIS PROGRAM IDENTIFIES THE MEMBERS OF A FAMILY WHICH ARE ASSOCIATED TO
   A BODY *idesig_to_start* AT A LEVEL *limit* (TO BE SET BELOW)
   WORKS ON ANALYTICAL ELEMENTS OF MILANI AND KNEZEVIC, HCM OF ZAPPALA ET AL. */

// ADAPTED TO READ/WRITE new catalogue AstOrb + AstDyS + WISE + SLOAN

#include<stdio.h>
#include<math.h>
#include<stdlib.h>
#include<string.h>

#include "nrutil.h"
#include "nrutil.c"

#define PI2 6.28318530717959
#define AU 1.49597870e11 // IN METERS

#define GAUSS 0.01720209895
#define GM (GAUSS*GAUSS*365.25*365.25) //UNITS: JULIAN YEARS, AU, SUN MASS

#define FACTOR (AU/365.25/86400.) // CONVERSION FACTOR FROM AU/YR TO M/S

#define MAXN_IN_LIMIT 500 // MAXIMUM NUMBER OF BODIES ALLOWED WITHIN A *LIMIT* ABOUT ANY BODY
                           // IF EXCEEDED, PROGRAM GIVES A RUN-TIME ERROR MESSAGE AND EXISTS

#define NTPMAX 200000 // MAXIMUM NUMBER OF BODIES IN CATALOGUES
#define NFAMILYMAX 100000 // MAXIMUM NUMBER OF BODIES IN FAMILY
#define LREC 1237 // LENGTH OF RECORD IN M&K CATALOGUES <- INCLUDING NEWLINE!
#define MAXDESIG 10 // MAXIMUM LENGTH OF AN ASTEROID DESIGNATION

static double sqrarg;
#define SQR(a) ((sqrarg=(a)) == 0.0 ? 0.0 : sqrarg*sqrarg)

/**********************************************************************/

void fgetfield(FILE *fp,char s[],int length);

char **cmatrix(long nrl, long nrh, long ncl, long nch);

/**********************************************************************/

int main(int argc, char *argv[]){

  char field[LREC];
  char **cats;
  char **desig;
  long int i,j,k,l,inew,ide,ntpnumb,ntpmult,ntp;
  long int *idesig,*nassoc,**assoc,nfamily,*family;
  long int idesig_to_start, k_to_start;
  char desig_to_start[MAXDESIG];
  char desig1[MAXDESIG];
  char catalogue[80];
  double *sema,*ecc,*sinc,n,g,s,*mag,LCE,My;
  double limit,sqrfac,metrics,maglimit;
  FILE *fp;

  // SEPARATION LIMIT, IN M/S, MUST BE LARGER THAN QRL (quasi-random level) (ZAPPALA ET AL.)

  if (argc != 5) {
      printf("Usage: hcluster4  DESIGNATION V_cutoff H_limit FILENAME_catalogue\n");
      return 1;
  }

  sscanf(argv[1], "%10s",&desig_to_start);
  sscanf(argv[2], "%lg", &limit);
  sscanf(argv[3], "%lg", &maglimit);
  sscanf(argv[4], "%80s", &catalogue);

  printf("# desig_to_start = %s\n", desig_to_start);
  printf("# v_cutoff = %lg m/s\n", limit);
  printf("# maglimit = %lg mag\n", maglimit);
  printf("# catalogue = %s\n", catalogue);

  limit = limit*limit;

  //********************************************************************************

  sqrfac = SQR(FACTOR); // TO AVOID SQUARE ROOT IN METRICS, WORK WITH METRICS^2

  ntp = NTPMAX;

  sema = dvector(1,ntp); ecc = dvector(1,ntp); sinc = dvector(1,ntp);
  mag =  dvector(1,ntp);

  nassoc = lvector(1,ntp);
  assoc = lmatrix(1,ntp,1,MAXN_IN_LIMIT);
  family = lvector(1,ntp);

  cats = cmatrix(1,ntp,1,LREC+1);
  desig = cmatrix(1,ntp,1,MAXDESIG+1);
  
  // READ THE PROPER ELEMENTS OF NUMBERED ASTEROIDS
  fp = fopen(catalogue,"r");
  if (fp == NULL) {
    printf("Error reading file %s.\n",catalogue);
    return;
  }

//  while(fgetc(fp) != '\n');

  i=1;

  fgetfield(fp,field,LREC);

  while (! feof(fp)) {
    sscanf(field + 271,"%10s %lg %lg %lg %lg %lg %d %d %d %lg",
      &desig1,&mag[i],&sema[i],&ecc[i],&sinc[i],&n,&g,&s,&LCE,&My);
    strcpy(cats[i],field);
    strcpy(desig[i],desig1);

    i++;
    fgetfield(fp,field,LREC);
  }

  fclose(fp);

  ntpnumb = i-1;
  ntpmult = 0;
  ntp = ntpnumb + ntpmult;
  printf("# ntp = %ld\n",ntp);

  // WHAT IS THE BODY TO START WITH ?
  i = 1;
  while(strcmp(desig[i], desig_to_start) && i<ntp) { i++; };

  if(strcmp(desig[i], desig_to_start)){
    fprintf(stderr,"The central body, %s, not found ...\n", desig_to_start);
    fprintf(stderr,"Exiting now ...\n");
    return 0;
  }

  k_to_start = i;
  printf("# desig = %10s, idx = %d, a = %lg, e = %lg, sini = %lg\n",desig[i],i,sema[i],ecc[i],sinc[i]);

  // NASSOC[I] IS # OF BODIES WITHIN *LIMIT* DISTANCE TO BODY *I*, INITIALLY SET TO ZERO
  for(i=1;i<=ntp;i++)
    nassoc[i] = 0;

  // SELECTION OF BODIES LINKED WITH *idesig_to_start*
  k = k_to_start;
  nfamily = 1;
  family[nfamily] = k;       // add *idesig_to_start* as 1st body to the family list

  i = 1;  /* run with *i* over the current list of family members,
	     attaching additional branches */

  while(i <= nfamily){  // stop if *i* is larger than the current family list: no more branches

    k = family[i];   /* run over the bodies associated to *i* body */

    for(j=1;j<=ntp;j++)

      if(j != k){

	// D1 METRICS SQUARED (!) OF ZAPPALA ET AL. 1994
	metrics =
	  1.25*SQR( 2.00*(sema[j] - sema[k])/(sema[k] + sema[j]) ) +
	  2.00*SQR(  ecc[j]  - ecc[k]           ) +
	  2.00*SQR(  sinc[j] - sinc[k]          );

	  metrics = 2. * metrics*GM/(sema[j] + sema[k]) * sqrfac;

	  // IF J-TH BODY IS CLOSER THAN *LIMIT*, ASSOCIATE IT TO I-TH BODY
	  if(metrics <= limit && mag[j] <= maglimit){
	    nassoc[k] ++;

	    if(nassoc[k] > MAXN_IN_LIMIT){
	      fprintf(stderr,"Number of associated bodies to %ld exceeds MAXN_IN_LIMIT ...\n",k);
	      fprintf(stderr,"Increase MAXN_IN_LIMIT, Exiting ...");
	      return 0;
	    }

	    assoc[k][nassoc[k]] = j;
	  }

      }

    for(j=1;j<=nassoc[k];j++){

      inew = 1;      /* see if bodies associated to *k* are already in the family list */
      for(l=1;l<=nfamily;l++)
	if(assoc[k][j] == family[l] )
	  inew = 0;

      if(inew == 1){    /* if this is a new body, add it to the family list */
	nfamily++;
	family[nfamily] = assoc[k][j];
        if (nfamily > NFAMILYMAX) {
	   fprintf(stderr,"Number of family members %ld exceeds NFAMILYMAX ...\n",nfamily);
	   fprintf(stderr,"Increase NFAMILYMAX, Exiting ...");
           return 1;
        }
      }

    }

    i++;
  }

  printf("# n_family = %d\n\n", nfamily);

  // OUTPUT AN UNSORTED FAMILY LIST
  /*fp = fopen("family.list","w");
  for(i=1;i<=nfamily;i++){
    fprintf(fp,"%s",cats[family[i]]);
  }
  fclose(fp);
  */

  for(i=1;i<=nfamily;i++){
    printf("%s",cats[family[i]]);
  }

  return 0;
}

/**********************************************************************/

void fgetfield(FILE *fp,char s[],int length){
  int i;

  for(i=0;i<length;i++)
    s[i]=fgetc(fp);
  s[i]='\0';
}

/**********************************************************************/

char **cmatrix(long nrl, long nrh, long ncl, long nch)
/* allocate a double matrix with subscript rangem[nrl..nrh][mcl..nch] */
{
	long i, nrow=nrh-nrl+1,ncol=nch-ncl+1;
	char **m;

/* allocate pointers to rows */
	m=(char **) ALLOCATE((size_t)((nrow+NR_END)*sizeof(char*)));
	if (!m) nrerror("allocation failure 1 in cmatrix()");
	m += NR_END;
	m -= nrl;

/* allocate rows and set pointers to them */
	m[nrl]=(char *) ALLOCATE((size_t)((nrow*ncol+NR_END)*sizeof(char)));
	if (!m[nrl]) nrerror("allocation failure 2 in cmatrix()");
	m[nrl] += NR_END;
	m[nrl] -= ncl;

	for(i=nrl+1;i<=nrh;i++) m[i]=m[i-1]+ncol;

/* return pointer to array of pointers to rows */
	return m;
}

/**********************************************************************/

