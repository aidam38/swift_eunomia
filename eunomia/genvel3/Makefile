
f77 = gfortran
cc = gcc
opt = -O3
obj = a.o ran1.o

genvel3: genvel3.f $(obj)
	$(f77) $(obj) $(opt) -o $@ $<

$(obj) : %.o:%.f
	$(f77) -c $(opt) $<

clean : FORCE
	rm $(obj)
FORCE :


