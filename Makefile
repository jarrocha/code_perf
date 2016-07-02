#Makefile for psum1

GCC= gcc
GFLAGS1= -fno-asynchronous-unwind-tables -S
GFLAGS2= -pg -g -Wall
GFLAGS3= -Wall
IN= psum1.c

psum2:
	$(GCC) $(GFLAGS2) -o psum2 psum2.c
psum2.s:
	$(GCC) $(GFLAGS1) psum2.c
psum1:
	$(GCC) $(GFLAGS2) -o psum1 $(IN)
psum1_O1:
	$(GCC) $(GLFAGS2) -O1 -o psum1_O1 $(IN)
psum1_O2:
	$(GCC) $(GLFAGS2) -O2 -o psum1_O2 $(IN)
psum1_O3:
	$(GCC) $(GLFAGS2) -O3 -o psum1_O3 $(IN)
psum1.s:
	$(GCC) $(GFLAGS1) $(IN)
clean:
	rm -rf psum1 psum1.s
