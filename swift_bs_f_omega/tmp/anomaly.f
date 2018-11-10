
       implicit none

       real*8 pi,deg,rad
       parameter(pi=3.1415926535d0, deg=pi/180.d0, rad=180.d0/pi)

       real*8 a,e,inc,node,peri,M,f,u
       real*8 ekepl1


       read(*,*) a,e,inc,peri,node,M

       inc = inc*deg
       node = node*deg
       peri = peri*deg
       M = M*deg                                 ! mean anomaly

       u = ekepl1(M,e)                           ! eccentric anomaly (also denoted E)
       f = acos((cos(u)-e) / (1.d0-e*cos(u)))    ! true anomaly

       write(*,*) 'M = ', M*rad, ' deg'
       write(*,*) 'u = ', u*rad, ' deg (= E)'
       write(*,*) 'f = ', f*rad, ' deg'
       write(*,*) 'omega+f = ', (peri+f)*rad, ' deg = ',
     :   ((peri+f)*rad-360.d0), ' deg'

       end       


c**********************************************************************
      double precision function ekepl1(m,e)
c**********************************************************************
c       
c  keplers equotion, eccentric anomaly, legendre-based starter and
c  halley iterator, method described in
c  Odell, A. W., Gooding, R. H.: Procedures for solving Kepler's
c  equotion. Tech. Memo Space 356, p. 35, January 1986
c  m  mean anomaly
c  e  eccentricity
c 
      double precision m,e,eps,c,s,psi,psi0,xi,eta,fd,fdd,f
      parameter(eps=1d-13) 
      c=e*cos(m)
      s=e*sin(m)
      psi=s/sqrt(1d0-c-c+e*e)
1     xi=cos(psi)
      eta=sin(psi)
      fd=(1d0-c*xi)+s*eta
      fdd=c*eta+s*xi
      f=psi-fdd
      psi0=psi
      psi=psi-f*fd/(fd*fd-5d-1*f*fdd)
      if (abs(psi-psi0).ge.eps) goto 1
      ekepl1=m+psi
      return
      end


