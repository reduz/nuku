all: copy_and_filter.c nuku.pas
	gcc -c copy_and_filter.c -O3 -ffast-math -funroll-loops -march=pentium
	ar cru libcopy_and_filter.a copy_and_filter.o
	ranlib libcopy_and_filter.a
	ppc386 -Rintel -g -Fl. nuku.pas 