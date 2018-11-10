# Makefile for SyMBA integrator with filters from swift-rmvsy.
# Miroslav Broz (miroslav.broz@email.cz), Aug 22nd 2006

f77 = gfortran
cc = gcc

opt = -O3

libswift = -lswift -L.

obj = \
  io/io_write_frame_r8.o \
  io/io_write_hdr_r8.o \
  io/io_write_line_r8.o \
  misc/length.o \
  misc/zero2pi.o \
  util/util_version.o \

objc = \

inc = \
  swift.inc \
  version.inc \

all: main/swift_bs_f_omega

main/swift_bs_f_omega: main/swift_bs_f_omega.f $(obj) $(objc) $(inc)
	$(f77) $(opt) $(obj) $(objc) -o $@ $< $(libswift)

$(obj) : %.o:%.f $(inc)
	$(f77) $(opt) -c -o $@ $<

$(objc) : %.o:%.c
	$(cc) $(opt) -c -o $@ $<

clean : FORCE
	rm -f $(obj) $(objc)

FORCE :


