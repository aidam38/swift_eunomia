c  v_gauss.f
c  Calculate change of orbital elements according to the Gauss equations.
c    (see Bertotti et al. 2003, ch. 12);
c  v souboru fyzika_malych_teles.pdf je to spatne! (viz chyba nize)
c  Miroslav Broz (miroslav.broz@email.cz), Aug 2nd 2006

      program v_gauss

      implicit none

      real*8 pi,deg,rad
      parameter(pi=3.1415926535d0, deg=pi/180.d0, rad=180.d0/pi)

      real*8 GM, AU
      parameter(GM=0.2959122082855911d-03)    ! solar mass for G=1, AU, day
      parameter(AU=1.49597870d11)             ! m
c  k_gauss = sqrt(GM) = 0.01720209895 rad/day; velocity units are AU/day
      real*8 ms_auday
      parameter(ms_auday=86400.d0/AU)

      real*8 a,e,f,omega,omega_plus_f, u,n,r
      real*8 Dv_R,Dv_T,Dv_W, Da,De,DI
      integer i,nv,iu
      character*80 s,genvelfile

      if (iargc().eq.0) then
        read(*,*) a
        read(*,*) e
        read(*,*) f
        read(*,*) omega_plus_f
        read(*,10) genvelfile
10      format(a)
        iu=10

c check command-line arguments
      else if (iargc().eq.4) then
        call getarg(1,s)
        read(s,*,err=15,end=15) a
        call getarg(2,s)
        read(s,*,err=15,end=15) e
        call getarg(3,s)
        read(s,*,err=15,end=15) f
        call getarg(4,s)
        read(s,*,err=15,end=15) omega_plus_f
        iu=5
      else
15      continue
        write(*,*) 'Usage: v_gauss a e f omega_plus_f; ',
     :    'velocities from stdin'
        stop
      endif

      f = f*deg                                 ! true anomaly
      omega_plus_f = omega_plus_f*deg
      omega = omega_plus_f-f                    ! argument of pericentre
      u = acos((e+cos(f)) / (1.d0+e*cos(f)))    ! eccentric anomaly; ERROR!!! acos was missing here! corrected on Aug 2nd 2006
      n = sqrt(GM/a**3)                         ! mean motion
c      r = a*(1.d0-e**2)/(1.d0 + e*cos(u-omega)) ! ERROR! u is eccentric anomaly; corrected on Jun 14th 2008
      r = a*(1.d0-e*cos(u))                      ! this one is correct

c      r = a*(1.d0-e**2)/(1.d0 + e*cos(f))       ! or I can use this one
c      E = GM*m/(2.d0*a) => v = sqrt(GM*(2.d0/r - 1.d0/a))

      if (iu.eq.10) then
        open(unit=iu,file=genvelfile,status='old')
      endif

5     continue
        read(iu,*) s
      if (s(1:1).eq.'#') goto 5
      read(s,*) nv
      write(*,*) nv

      do i=1,nv
        read(iu,*) Dv_R, Dv_T, Dv_W

        Dv_R = Dv_R*ms_auday
        Dv_T = Dv_T*ms_auday
        Dv_W = Dv_W*ms_auday

        Da = 2.d0/(n*sqrt(1.d0-e**2))
     :     * (Dv_T + e*(Dv_T*cos(f) + Dv_R*sin(f)))
        De = sqrt(1.d0-e**2)/(n*a)
     :     * (Dv_R*sin(f) + Dv_T*(cos(f) + cos(u)))
        DI = Dv_W/(n*a*sqrt(1.d0-e**2)) * (r/a) * cos(omega + f)

c        write(*,*) Da, De, DI*rad
        write(*,*) Da, De, DI
      enddo

      if (iu.eq.10) then
        close(iu)
      endif

      stop
      end


