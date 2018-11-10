c secres.f
c Calculate several combinations of secular frequencies
c   (and plot secular resonances later by gnuplot).
c Miroslav Broz (miroslav.broz@email.cz), Mar 23rd 2009

      program secres

      implicit none

      include "ngridmax.inc"
      include "secres.inc"

      integer ngrid,i,j
      real gs(ngridmax**2,2)
      real gq(ngridmax,ngridmax),sq(ngridmax,ngridmax)
      real ra1,ra2,rI1,rI2,re1,re2,w,om

      external d10,d13,d46,d2,z2,z3,d61,g_s_g5_s6,TWOg_g5_g6,
     :  TWOg_s_2g5_s7
      character*255 str

      common ngrid,gq,sq

c  read file datam.m produced by secre8 program
      open(unit=1,file="datam.m")
      read(1,10) str
10    format(a)
      close(1)

      str=str(8:101)
      read(str,*) ngrid,ra1,ra2,rI1,rI2,re1,re2,w,om

c  read g and s frequencies as column data
      open(unit=2,file="gs.fla")
      do i = 1, ngrid**2
        read(2,*) gs(i,1),gs(i,2)
      enddo
      close(2)

c  reorder them as square matrix data
      do i = 1, ngrid
        do j = 1, ngrid
          gq(i,j) = gs(1-i+j*ngrid,1)
          sq(i,j) = gs(1-i+j*ngrid,2)
        enddo
      enddo

c  calculate a desired combination of frequences (by given function) and write output file
      call writeout("d10.dat",d10)
      call writeout("d13.dat",d13)
      call writeout("d46.dat",d46)
      call writeout("d2.dat",d2)
      call writeout("z2.dat",z2)
      call writeout("z3.dat",z3)
      call writeout("d61.dat",d61)

c  these two are possibly suitable for Hungarias
      call writeout("g_s_g5_s6.dat", g_s_g5_s6)
      call writeout("2g_g5_g6.dat", TWOg_g5_g6)
      call writeout("2g_s_2g5_s7.dat", TWOg_s_2g5_s7)

      end

c***********************************************************************
      subroutine writeout(file,func)
c***********************************************************************
      character*(*) file
      include "ngridmax.inc"
      external func
      integer ngrid
      real gq(ngridmax,ngridmax),sq(ngridmax,ngridmax)
      common ngrid,gq,sq
      real d(ngridmax,ngridmax)
      integer i,j

      do i = 1, ngrid
        do j = 1, ngrid
          d(i,j) = func(gq(i,j),sq(i,j))
        enddo
      enddo

20    format(101(1x,f12.6))
      open(unit=3,file=file)
      do i = 1, ngrid
        write(3,20) (d(i,j),j=1,ngrid)
      enddo
      close(3)

      return
      end

c***********************************************************************
      real function d10(gq,sq)
      include "secres.inc"
      d10 = gq+sq-g6-s6
      return
      end

c***********************************************************************
      real function d13(gq,sq)
      include "secres.inc"
      d13 = gq-2*g6+g5
      return
      end

c***********************************************************************
      real function d46(gq,sq)
      include "secres.inc"
      d46 = sq-s6-g5+g6
      return
      end

c***********************************************************************
      real function d2(gq,sq)
      include "secres.inc"
      d2 = gq-g6
      return
      end

c***********************************************************************
      real function z2(gq,sq)
      include "secres.inc"
      z2 = (gq-g6)*2+(sq-s6)
      return
      end

c***********************************************************************
      real function z3(gq,sq)
      include "secres.inc"
      z3=(gq-g6)*3+(sq-s6)
      return
      end

c***********************************************************************
      real function d61(gq,sq)
      include "secres.inc"
      d61 = gq-3*g6+2*g5
      return
      end

c***********************************************************************
      real function TWOg_g5_g6(gq,sq)
      include "secres.inc"
      TWOg_g5_g6 = 2*gq-g5-g6
      return
      end

c***********************************************************************
      real function g_s_g5_s6(gq,sq)
      include "secres.inc"
      g_s_g5_s6 = gq+sq-g5-s6
      return
      end

c***********************************************************************
      real function TWOg_s_2g5_s7(gq,sq)
      include "secres.inc"
      TWOg_s_2g5_s7 = 2*gq+sq-2*g5-s7
      return
      end


