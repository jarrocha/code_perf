#Makefile for psum1

GCC= gcc
GFLAGS1= -fno-asynchronous-unwind-tables -S
GFLAGS2= -pg -Wall
IN= psum1.c

psum1:
	$(GCC) $(GFLAGS2) -o psum1 $(IN)

psum1.s:
	$(GCC) $(GFLAGS1) $(IN)
clean:
	rm -rf psum1 psum1.s
