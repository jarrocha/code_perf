	.file	"psum1.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.p2align 4,,15
	.globl	vec_length
	.type	vec_length, @function
vec_length:
	movq	(%rdi), %rax
	ret
	.size	vec_length, .-vec_length
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely
.LCOLDB1:
	.text
.LHOTB1:
	.p2align 4,,15
	.globl	get_vec_element
	.type	get_vec_element, @function
get_vec_element:
	xorl	%eax, %eax
	testq	%rsi, %rsi
	js	.L3
	cmpq	(%rdi), %rsi
	jge	.L3
	movq	16(%rdi), %rax
	movl	(%rax,%rsi,4), %eax
	movl	%eax, (%rdx)
	movl	$1, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L3:
	rep ret
	.size	get_vec_element, .-get_vec_element
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.section	.text.unlikely
.LCOLDB2:
	.text
.LHOTB2:
	.p2align 4,,15
	.globl	combine1
	.type	combine1, @function
combine1:
	movq	(%rdi), %r8
	testq	%r8, %r8
	jle	.L8
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L10:
	testq	%rax, %rax
	js	.L9
	movq	16(%rdi), %rcx
	movl	(%rcx,%rax,4), %esi
.L9:
	movslq	%esi, %rcx
	addq	$1, %rax
	addq	%rcx, %rdx
	cmpq	%r8, %rax
	jne	.L10
.L8:
	movq	%rdx, 8(%rdi)
	ret
	.size	combine1, .-combine1
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC3:
	.string	"Error allocating"
.LC4:
	.string	"Invalid len size. Quitting"
.LC5:
	.string	"Error allocating data"
	.section	.text.unlikely
.LCOLDB6:
	.text
.LHOTB6:
	.p2align 4,,15
	.globl	new_vec
	.type	new_vec, @function
new_vec:
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbp
	pushq	%rbx
	movq	%rdi, %rbx
	movl	$24, %edi
	call	malloc
	testq	%rax, %rax
	movq	%rax, %r13
	je	.L19
	testq	%rbx, %rbx
	movq	%rbx, (%rax)
	jle	.L20
	leaq	0(,%rbx,4), %rdi
	call	malloc
	testq	%rax, %rax
	movq	%rax, %rbp
	movq	%rax, 16(%r13)
	je	.L21
	xorl	%r14d, %r14d
	movl	$1717986919, %r12d
	.p2align 4,,10
	.p2align 3
.L15:
	call	rand
	movl	%eax, %ecx
	imull	%r12d
	movl	%ecx, %eax
	sarl	$31, %eax
	sarl	$2, %edx
	subl	%eax, %edx
	leal	(%rdx,%rdx,4), %eax
	addl	%eax, %eax
	subl	%eax, %ecx
	addl	$1, %ecx
	movl	%ecx, 0(%rbp,%r14,4)
	addq	$1, %r14
	cmpq	%r14, %rbx
	jne	.L15
	popq	%rbx
	movq	%r13, %rax
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	ret
.L19:
	movl	$.LC3, %edi
	call	puts
	movl	$1, %edi
	call	exit
.L21:
	movq	%r13, %rdi
	call	free
	movl	$.LC5, %edi
	call	puts
	movl	$1, %edi
	call	exit
.L20:
	movl	$.LC4, %edi
	call	puts
	movl	$1, %edi
	call	exit
	.size	new_vec, .-new_vec
	.section	.text.unlikely
.LCOLDE6:
	.text
.LHOTE6:
	.section	.rodata.str1.1
.LC7:
	.string	"Usage: %s [ARRAY_ELEMENTS]\n"
.LC8:
	.string	"User entered %ld\n"
.LC9:
	.string	"Final result %ld\n"
	.section	.text.unlikely
.LCOLDB10:
	.section	.text.startup,"ax",@progbits
.LHOTB10:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
	pushq	%r13
	pushq	%r12
	movl	%edi, %r13d
	pushq	%rbp
	pushq	%rbx
	xorl	%edi, %edi
	movq	%rsi, %r12
	subq	$8, %rsp
	call	time
	movl	%eax, %edi
	call	srand
	cmpl	$2, %r13d
	jne	.L29
	movq	8(%r12), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol
	movl	$.LC8, %edi
	movq	%rax, %rsi
	movq	%rax, %r12
	xorl	%eax, %eax
	call	printf
	movq	%r12, %rdi
	call	new_vec
	movq	(%rax), %rsi
	movq	%rax, %r12
	testq	%rsi, %rsi
	jle	.L24
	xorl	%edx, %edx
	.p2align 4,,10
	.p2align 3
.L26:
	testq	%rdx, %rdx
	js	.L25
	movq	16(%r12), %rax
	movl	(%rax,%rdx,4), %ebp
.L25:
	movslq	%ebp, %rcx
	addq	$1, %rdx
	addq	%rcx, %rbx
	cmpq	%rsi, %rdx
	jne	.L26
.L24:
	movq	%rbx, 8(%r12)
	movq	%rbx, %rsi
	movl	$.LC9, %edi
	xorl	%eax, %eax
	call	printf
	movq	%r12, %rdi
	call	free
	addq	$8, %rsp
	xorl	%eax, %eax
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
.L29:
	movq	(%r12), %rsi
	movl	$.LC7, %edi
	xorl	%eax, %eax
	call	printf
	xorl	%edi, %edi
	call	exit
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE10:
	.section	.text.startup
.LHOTE10:
	.ident	"GCC: (Debian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
