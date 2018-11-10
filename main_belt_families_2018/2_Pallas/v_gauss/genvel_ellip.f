c
c  Generate an elliptic constant velocity distribution.
c
      program genvel_ellipse
      implicit none

      real*8 vej,vx,vy,vz,s1,coss2,sins2,TWOPI,x
      integer n,i,idum
      character*80 s
c  functions
      real*8 ran1

      parameter(TWOPI=6.283185307d0)

      if (iargc().eq.0) then
        read(*,*) x
        read(*,*) vej
        read(*,*) idum
c check command-line arguments
      else if (iargc().eq.3) then
        call getarg(1,s)
        read(s,*,err=15,end=15) x
        call getarg(2,s)
        read(s,*,err=15,end=15) vej
        call getarg(3,s)
        read(s,*,err=15,end=15) idum
      else
15      continue
        write(*,*) 'Usage: genvelconst n vej [m/s] idum'
        stop
      endif

      n = int(x)
      write(*,*) n

      do i = 1,n
c        s1=TWOPI*ran1(idum)
c        coss2=2.d0*ran1(idum)-1.d0
        s1=TWOPI/4.d0+TWOPI*(i-1)/(n-1)
        coss2=0.d0
        sins2=sqrt(1.d0-coss2**2)
        vx=vej*cos(s1)*sins2
        vy=vej*sin(s1)*sins2
        vz=vej*coss2
        write(*,20) vx,vy,vz
20      format(3(1x,e22.16))
      enddo

      stop
      end

