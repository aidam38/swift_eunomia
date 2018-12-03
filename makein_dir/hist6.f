c Histogram calculation
c
c input: number of bins, range (min max) and data filename
c output: 
c
c (Notice: values outside the range are dropped!
c while hist3 adds them to the outermost bins.)
c
c In comparison to hist4, the output x coordinate is
c in the MIDDLE of the bin, because it correspons better
c to Gnuplot plotting capabilities (with hist style).
c
c We use command-line arguments instead of stdin.
c
c Miroslav Broz, miroslav.broz@email.cz, Nov 5th 2002

      program hist5

      implicit none

      integer maxx,maxn
      parameter(maxx = 8000000)
      parameter(maxn = 10000)
    
      integer i,j,maxi,nbin,k
      integer n(maxn)
      real*8 sum,eps
      real*8 x(maxx),x_max,x_min,dx
      character*80 fname,str

      data n /maxn*0/
      parameter(eps=1e-8)

c-----------------------------------------------------------------------
c  input
      if (iargc().ne.4) then
        write(*,*) "Usage: nbin x_min x_max filename"
        stop
      endif

      call getarg(1, str)
      read(str,*) nbin
      call getarg(2, str)
      read(str,*) x_min
      call getarg(3, str)
      read(str,*) x_max
      call getarg(4, fname)

c  read data
      i = 1
      open(unit=1,file=fname,status="old")
10    continue
c        read(1,*,err=20,end=20) x(i)
        read(1,*,err=20,end=20) str
        if (str(1:1).eq."#") goto 10
        read(str,*,err=20,end=20) x(i)
c        write(*,*) x(i)
        i = i + 1 
      if (i.le.maxx) goto 10
20    continue
      close(1)
      maxi = i-1

c  determine min, max, dx
      if (x_max.lt.x_min) then
        x_max = x(1)
        x_min = x(maxi)
        do i = 1, maxi
          if (x_min.gt.x(i)) x_min = x(i)
          if (x_max.lt.x(i)) x_max = x(i)
        enddo
      endif

      x_max = x_max + eps*(x_max-x_min)
      dx = (x_max-x_min)/nbin
c      write(*,*) x_min,x_max,dx,nbin,maxi

c  calc histogram
      k = 0
      do i = 1, maxi
        j = int((x(i)-x_min)/dx)+1
        k = k + 1
        if ((j.gt.0).and.(j.le.nbin)) then
          n(j) = n(j) + 1
        endif
      enddo
c      write(*,*) k

c  write output
      sum = 0.0
      do i = 0, nbin-1
        k = i + 1
        if (k.gt.nbin) k = nbin
        write(*,*) x_min+i*dx+0.5*dx,real(n(k))/real(maxi),n(k)
c        sum = sum + 1.0d0*n(i)
c        write(*,*) x_min+i*dx,sum
      enddo

      end
c-----------------------------------------------------------------------

