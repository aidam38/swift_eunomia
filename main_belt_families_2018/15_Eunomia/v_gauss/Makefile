
f77 = gfortran
cc = gcc
opt = -O3
obj = a.o ran1.o

all: v_gauss genvel_const genvel_ellip genvel_ellip2

v_gauss: v_gauss.f $(obj)
	$(f77) $(obj) $(opt) -o $@ $<

genvel3: genvel3.f $(obj)
	$(f77) $(obj) $(opt) -o $@ $<

genvel3_rho: genvel3_rho.f $(obj)
	$(f77) $(obj) $(opt) -o $@ $<

genvel_const: genvel_const.f $(obj)
	$(f77) $(obj) $(opt) -o $@ $<

genvel_ellip: genvel_ellip.f $(obj)
	$(f77) $(obj) $(opt) -o $@ $<

genvel_ellip2: genvel_ellip2.f $(obj)
	$(f77) $(obj) $(opt) -o $@ $<

genvel_cone: genvel_cone.f $(obj)
	$(f77) $(obj) $(opt) -o $@ $<

$(obj) : %.o:%.f
	$(f77) -c $(opt) $<

clean : FORCE
	rm $(obj)
FORCE :


#genvel3: genvel3.f $(obj)
#	$(f77) $(obj) $(opt) -o $@ $<
#
#objc = 
#
#$(objc) : %.o:%.c
#	$(cc) -c -O3 $<

