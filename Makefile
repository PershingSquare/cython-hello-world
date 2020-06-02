CC = gcc
LDIR = lib

default: libadd.a

libadd.a: add_cpu.o
	ar rcs $@ $^
	mkdir -p lib
	mv $@ lib/$@

cpuadd.o: add_cpu.c add_cpu.h
	$(CC) -c $<

clean:
	rm -rf *.o *.a *.so *.html add.c lib build
