extern printf

section .data
	_string db "Waqar", 0
	_string_len equ $ - _string-1

	fmt_original db "The original string: %s", 10, 0
	fmt_reversed db "The reversed string: %s", 10, 0

section .bss
section .text
	global main

main:
	push rbp
	mov rbp, rsp ;save stack ptr

	; print the original string
	mov rdi, fmt_original
	mov rsi, _string
	mov rax, 0
	call printf

	; PUSH the string char by char on the stack
	xor rax, rax 			; clear rax
	mov rbx, _string 		; address of _string in rbx
	mov rcx, _string_len 	; length in rcx counter
	mov r12, 0 				; use r12 as ptr

pushLoop:
	mov al, byte [rbx + r12]
	push rax
	inc r12
	loop pushLoop

	; POP the string char by char from the stack
	mov rbx, _string
	mov rcx, _string_len
	mov r12, 0

popLoop:
	pop rax 		; pop a char into rax
	mov byte [rbx + r12], al 	; move char into _string, (rbx has string address)
	inc r12
	loop popLoop
	mov byte [rbx + r12], 0 	; terminate with 0

	; print the reversed string
	mov rdi, fmt_reversed
	mov rsi, _string
	mov rax, 0
	call printf

	mov rsp, rbp 	;restore stack ptr
	pop rbp
	ret


