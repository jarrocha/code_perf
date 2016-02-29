	.file	"psum1.c"
	.text
	.globl	vec_length
	.type	vec_length, @function
vec_length:
	movq	(%rdi), %rax
	ret
	.size	vec_length, .-vec_length
	.globl	get_vec_element
	.type	get_vec_element, @function
get_vec_element:
	testq	%rsi, %rsi
	js	.L4
	movl	$0, %eax
	cmpq	(%rdi), %rsi
	jge	.L3
	movq	16(%rdi), %rax
	movl	(%rax,%rsi,4), %eax
	movl	%eax, (%rdx)
	movl	$1, %eax
	ret
.L4:
	movl	$0, %eax
.L3:
	rep ret
	.size	get_vec_element, .-get_vec_element
	.globl	combine1
	.type	combine1, @function
combine1:
	pushq	%r12
	pushq	%rbp
	pushq	%rbx
	subq	$16, %rsp
	movq	%rdi, %rbp
	cmpq	$0, (%rdi)
	jle	.L7
	movl	$0, %ebx
.L8:
	leaq	12(%rsp), %rdx
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	get_vec_element
	movslq	12(%rsp), %rax
	addq	%rax, %r12
	addq	$1, %rbx
	cmpq	0(%rbp), %rbx
	jl	.L8
.L7:
	movq	%r12, 8(%rbp)
	addq	$16, %rsp
	popq	%rbx
	popq	%rbp
	popq	%r12
	ret
	.size	combine1, .-combine1
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Error allocating"
.LC1:
	.string	"Invalid len size. Quitting"
.LC2:
	.string	"Error allocating data"
	.text
	.globl	new_vec
	.type	new_vec, @function
new_vec:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbp
	pushq	%rbx
	subq	$8, %rsp
	movq	%rdi, %r12
	movl	$24, %edi
	call	malloc
	movq	%rax, %r15
	testq	%rax, %rax
	jne	.L12
	movl	$.LC0, %edi
	call	puts
	movl	$1, %edi
	call	exit
.L12:
	movq	%r12, (%rax)
	testq	%r12, %r12
	jg	.L13
	movl	$.LC1, %edi
	call	puts
	movl	$1, %edi
	call	exit
.L13:
	leaq	0(,%r12,4), %rdi
	call	malloc
	movq	%rax, %r13
	movq	%rax, 16(%r15)
	testq	%rax, %rax
	jne	.L15
	movq	%r15, %rdi
	call	free
	movl	$.LC2, %edi
	call	puts
	movl	$1, %edi
	call	exit
.L15:
	movl	$0, %ebx
	movl	$1717986919, %r14d
.L14:
	movslq	%ebx, %rax
	leaq	0(%r13,%rax,4), %rbp
	call	rand
	movl	%eax, %ecx
	imull	%r14d
	sarl	$2, %edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	leal	(%rdx,%rdx,4), %eax
	addl	%eax, %eax
	subl	%eax, %ecx
	addl	$1, %ecx
	movl	%ecx, 0(%rbp)
	addl	$1, %ebx
	movslq	%ebx, %rax
	cmpq	%rax, %r12
	jg	.L14
	movq	%r15, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
	.size	new_vec, .-new_vec
	.section	.rodata.str1.1
.LC3:
	.string	"Usage: %s [ARRAY_ELEMENTS]\n"
.LC4:
	.string	"User entered %ld\n"
.LC5:
	.string	"Final result %ld\n"
	.text
	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	pushq	%rbx
	subq	$8, %rsp
	movl	%edi, %ebp
	movq	%rsi, %rbx
	movl	$0, %edi
	call	time
	movl	%eax, %edi
	call	srand
	cmpl	$2, %ebp
	je	.L19
	movq	(%rbx), %rsi
	movl	$.LC3, %edi
	movl	$0, %eax
	call	printf
	movl	$0, %edi
	call	exit
.L19:
	movq	8(%rbx), %rdi
	movl	$10, %edx
	movl	$0, %esi
	call	strtol
	movq	%rax, %rbx
	movq	%rax, %rsi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movq	%rbx, %rdi
	call	new_vec
	movq	%rax, %rbx
	movq	%rax, %rdi
	call	combine1
	movq	8(%rbx), %rsi
	movl	$.LC5, %edi
	movl	$0, %eax
	call	printf
	movq	%rbx, %rdi
	call	free
	movl	$0, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	ret
	.size	main, .-main
	.ident	"GCC: (Debian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
