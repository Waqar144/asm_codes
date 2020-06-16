section .data
num: dq 10

section .text
global _start
_start:

	mov rax, qword [num] ;10
	mov rbx, qword [num]  ;9
	dec rbx

xloop:
	mul rbx ; rax = rax * rbx
	dec rbx
	cmp rbx, 0
	jnz xloop

	nop

