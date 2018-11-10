c  genvel3.f
c  Generate an isotropic v**(-alpha) velocity distribution;
c  (one can later add it to a tp.in file).
c  See Farinella, P. et al.: Meteorite delivery and transport.
c    Asteroids, Comets, Meteors 1993, 1994, p. 207, (Eq. 2)
c  Miroslav Broz (miroslav.broz@email.cz), Jul 12th 2007
c
      program genvel3

      implicit none

      real*8 pi,G
      parameter(pi = 3.1415926535d0, G = 6.67e-11)

      real*8 vej,vmean,alpha,p,vmin,vmax,vx,vy,vz,s1,coss2,sins2,
     &  rstat,TWOPI,R,rho,dNmax,dN,vesc,x,vpeak
      integer n,i,idum
      character*80 s
c  functions
      real*8 ran1

      parameter(TWOPI=6.283185307d0)

      if (iargc().eq.0) then
        read(*,*) x
        read(*,*) alpha
        read(*,*) vmin
        read(*,*) vmax
        read(*,*) R
        read(*,*) rho
        read(*,*) idum

c check command-line arguments
      else if (iargc().eq.6) then
        call getarg(1,s)
        read(s,*,err=15,end=15) x
        call getarg(2,s)
        read(s,*,err=15,end=15) alpha
        call getarg(3,s)
        read(s,*,err=15,end=15) vmin
        call getarg(4,s)
        read(s,*,err=15,end=15) vmax
        call getarg(5,s)
        read(s,*,err=15,end=15) R
        call getarg(6,s)
        read(s,*,err=15,end=15) rho
        call getarg(7,s)
        read(s,*,err=15,end=15) idum
      else
15      continue
        write(*,*) 'Usage: genvel3 n alpha vmin vmax R rho idum'
        stop
      endif

c print input parameters for reference
      n = int(x)
      R = R*1.d3
      write(*,40) '# n = ',n,''
40    format(a,i5,a)
      write(*,30) '# alpha = ',alpha, ''
      write(*,30) '# vmin = ',vmin, ' m/s'
      write(*,30) '# vmax = ',vmax, ' m/s'
      write(*,30) '# R = ', R, ' m'
      write(*,30) '# rho = ',rho, ' kg/m^3'
      write(*,40) '# idum = ',idum,''

c calculate the escape velocity from the asteroid
c      vesc = 120.0 * (R/100.0)		! <- BEWARE! this is for a fixed density!!!
c 1/2 m v^2 = GMm / R => v = sqrt(2GM/r) = sqrt(2G 4/3 pi R^3 rho/R) = sqrt(8/3 pi G rho) * R
      vesc = sqrt(8./3.*pi*G*rho) * R

      write(*,30) '# vesc = ',vesc, ' m/s'
30    format(a,g12.6,a)

c      write(*,*) n
c      write(*,20) 0.d0,0.d0,0.d0

c Monte-Carlo algorithm to generate distribution of v
      dNmax = dN(vesc/sqrt(alpha),0.0d0,alpha,vesc)
      vmean=0.d0
      i=0
1     continue
        vej = vmax * ran1(idum)
        p = dNmax * ran1(idum)
        if (p.lt.dN(vej,vmin,alpha,vesc)) then
          i=i+1
          s1=TWOPI*ran1(idum)
          coss2=2.d0*ran1(idum)-1.d0    ! an error was here, (0,1) interval only!
          sins2=sqrt(1.d0-coss2**2)
          vx=vej*cos(s1)*sins2
          vy=vej*sin(s1)*sins2
          vz=vej*coss2
          write(*,20) vx,vy,vz
20        format(3(1x,e22.16))

          vmean=vmean+vej
        endif
c      if (i.lt.n-1) goto 1
      if (i.lt.n) goto 1

c calculate mean velocity "at infinity" (Eq. 2) among fragments
      vmean = vmean/n
      write(*,30) '# vmean = ',vmean, ' m/s'

c calculate peak (most typical) velocity
      vpeak = vesc/sqrt(alpha)
      write(*,30) '# vpeak = ',vpeak, ' m/s'

c mean ejection velocity (Eq. 1) should be equal to this
c <- this is NOT relevant for our case of v "at inifinity"
c      write(*,30) '# (alpha-1)/(alpha-2) * vmin = ',
c     :  ((alpha-1)/(alpha-2) * vmin), ' m/s'      ! dbg

      stop
      end

c-----------------------------------------------------------------------
      real*8 function dN(v,vmin,alpha,vesc)
      real*8 v,vmin,alpha,vesc 

      if (vmin<vesc) then
        dN = v * (v**2 + vesc**2)**(-(alpha+1.)/2.)
      else
        if (v>sqrt(vmin**2+vesc**2)) then
          dN = v * (v**2 + vesc**2)**(-(alpha+1.)/2.)
        else
          dN = 0.0
        endif
      endif  

      return
      end


