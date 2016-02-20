	.file	"psum1.c"
	.text
	.globl	vec_length
	.type	vec_length, @function
vec_length:
	pushq	%rbp
	movq	%rsp, %rbp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	popq	%rbp
	ret
	.size	vec_length, .-vec_length
	.globl	get_vec_element
	.type	get_vec_element, @function
get_vec_element:
	pushq	%rbp
	movq	%rsp, %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	cmpq	$0, -16(%rbp)
	js	.L4
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpq	-16(%rbp), %rax
	jg	.L5
.L4:
	movl	$0, %eax
	jmp	.L6
.L5:
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	movq	-16(%rbp), %rdx
	salq	$2, %rdx
	addq	%rdx, %rax
	movl	(%rax), %edx
	movq	-24(%rbp), %rax
	movl	%edx, (%rax)
	movl	$1, %eax
.L6:
	popq	%rbp
	ret
	.size	get_vec_element, .-get_vec_element
	.globl	combine1
	.type	combine1, @function
combine1:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$40, %rsp
	movq	%rdi, -40(%rbp)
	movq	$0, -8(%rbp)
	jmp	.L8
.L9:
	leaq	-20(%rbp), %rdx
	movq	-8(%rbp), %rcx
	movq	-40(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	get_vec_element
	movl	-20(%rbp), %eax
	cltq
	addq	%rax, -16(%rbp)
	addq	$1, -8(%rbp)
.L8:
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	vec_length
	cmpq	-8(%rbp), %rax
	jg	.L9
	movq	-40(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, 8(%rax)
	leave
	ret
	.size	combine1, .-combine1
	.section	.rodata
.LC0:
	.string	"Error allocating"
.LC1:
	.string	"Error allocating data"
	.text
	.globl	new_vec
	.type	new_vec, @function
new_vec:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	subq	$56, %rsp
	movq	%rdi, -56(%rbp)
	movl	$24, %edi
	call	malloc
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.L11
	movl	$.LC0, %edi
	call	puts
	movl	$1, %edi
	call	exit
.L11:
	movq	-32(%rbp), %rax
	movq	-56(%rbp), %rdx
	movq	%rdx, (%rax)
	cmpq	$0, -56(%rbp)
	jle	.L12
	movq	-56(%rbp), %rax
	salq	$2, %rax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, 16(%rax)
	movq	-32(%rbp), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	jne	.L12
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	free
	movl	$.LC1, %edi
	call	puts
	movl	$1, %edi
	call	exit
.L12:
	movq	-32(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -40(%rbp)
	movl	$0, -20(%rbp)
	jmp	.L13
.L14:
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-40(%rbp), %rax
	leaq	(%rdx,%rax), %rbx
	call	rand
	movl	%eax, %ecx
	movl	$1717986919, %edx
	movl	%ecx, %eax
	imull	%edx
	sarl	$2, %edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	subl	%eax, %ecx
	movl	%ecx, %edx
	leal	1(%rdx), %eax
	movl	%eax, (%rbx)
	addl	$1, -20(%rbp)
.L13:
	movl	-20(%rbp), %eax
	cltq
	cmpq	-56(%rbp), %rax
	jl	.L14
	movq	-32(%rbp), %rax
	addq	$56, %rsp
	popq	%rbx
	popq	%rbp
	ret
	.size	new_vec, .-new_vec
	.section	.rodata
.LC2:
	.string	"Enter size of array: "
.LC3:
	.string	"%ld"
.LC4:
	.string	"User entered %ld\n"
.LC5:
	.string	"Final result %ld\n"
	.text
	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	movl	$0, %edi
	call	time
	movl	%eax, %edi
	call	srand
	movl	$.LC2, %edi
	movl	$0, %eax
	call	printf
	leaq	-16(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC3, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	new_vec
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	combine1
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, %rsi
	movl	$.LC5, %edi
	movl	$0, %eax
	call	printf
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	free
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Debian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
