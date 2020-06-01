CC = gcc

default: libadd.a

libadd.a: add_cpu.o
	ar rcs $@ $^

cpuadd.o: add_cpu.c add_cpu.h
	$(CC) -c $<

clean:
	rm *.o *.a
