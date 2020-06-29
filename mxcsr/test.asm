section .data
	v1: dq 10.0
	v2: dq 3.0

section .text
	global main
main:
nop
	push rbp
	mov rbp, rsp
	mov rsi, v1
	mov rdx, v2
	movsd xmm2, [rsi]
	divsd xmm2, [rdx]
nop
