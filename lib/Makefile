CC = nvcc
GCC = gcc
CCFLAGS = -O3 -Xcompiler -static -Xcompiler -fPIC

default: libadd.a

libadd.a: add_cpu.o add_gpu.o
	ar rcs $@ $^

add_gpu.o: add_gpu.cu add_gpu.cuh
	$(CC) $(CCFLAGS) -c $<

add_cpu.o: add_cpu.c add_cpu.h
	$(GCC) -c $<

clean:
	rm *.a *.o
