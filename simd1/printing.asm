extern printf

section .data
	fmt: db "Hello, this is a good string", 10, 0

section .text
	global main
main:
	push rbp
	mov rbp, rsp
	
	mov rdi, fmt
	call printf

	leave
	ret
