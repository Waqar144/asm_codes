extern printf
section .data
	string: db "The quick brown fox jumps over the lazy river.", 0
	fmt1 	db "This is our string: %s", 10, 0
	fmt2 	db "Our string is %d chars long", 10, 0
section .bss
section .text
	global main
main:
	push rbp
	mov rbp, rsp

	mov rdi, fmt1
	mov rsi, string
	xor rax, rax
	call printf

	mov rdi, string
	call pstrlen
	mov rdi, fmt2
	mov rsi, rax
	xor rax, rax
	call printf

	leave
	ret

pstrlen:
	push rbp
	mov rbp, rsp

	mov rax, -16
	pxor xmm0, xmm0 ; packer xor, clear xmm0

	.notfound:
		add rax, 16
		pcmpistri xmm0, [rdi + rax], 00001000b
		jnz .notfound
		add rax, rcx
		inc rax

	leave
	ret
