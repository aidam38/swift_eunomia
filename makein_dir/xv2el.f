      program xv2el

      implicit none
      integer ntp
      real*8 y(6), elmts(6)
      real rstat
      integer istat
      integer i, j
      real*8 nula2pi
      real*8 a,h,k,p,q,lambda
      real*8 pi,deg,rad
      parameter(pi = 3.141592635d0, deg = pi / 180., rad = 180. / pi)

      read(*,*) ntp

      write(*,*) ntp

      do i = 1, ntp


        read(*,*) y(1), y(2), y(3)
        read(*,*) y(4), y(5), y(6)
c        write(*,*) y(1), y(2), y(3)
c        write(*,*) y(4), y(5), y(6)
        read(*,*) (istat,j=1,53)	
        read(*,*) (rstat,j=1,53)

        call e1(y(1),y(4),elmts)

        write(*,10) elmts(1), elmts(2), (nula2pi(elmts(j))*rad, j=3,6)
10      format(1x,f14.9,1x,f12.10,4(1x,f12.8))

        a = elmts(1)
        h = elmts(2) * sin(elmts(4)+elmts(5))
        k = elmts(2) * cos(elmts(4)+elmts(5))
        p = sin(elmts(3)/2) * sin(elmts(5))
        q = sin(elmts(3)/2) * cos(elmts(5))
        lambda = elmts(6) + elmts(4) + elmts(5)

c        write(*,20) a,h,k,p,q,nula2pi(lambda)
c20      format(1x,f12.9,4(1x,f12.9),1x,f12.8)

      enddo

      end

