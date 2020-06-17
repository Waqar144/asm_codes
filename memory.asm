section .data
	bNum db 123
	wNum dw 12345
	warray times 5 dw 0 ; array of 5 words containing 0
	dNum dd 12345
	qNum1 dq 12345
	text1 db "abc", 0
	qNum2 dq 3.1415
	text2 db "cde", 0

section .bss
	bvar resb 1
	dvar resd 1
	wvar resw 10
	qvar resq 3

section .text
	global main

main:
	push rbp
	mov rbp, rsp
	lea rax, [bNum] ; load address of bNum in rax
	mov rax, bNum 	; mov address of bNum in rax
	mov rax, [bNum] ; mov value of bNum in rax
	mov [bvar], rax ; mov rax into bvar
	lea rax, [bvar] ;
	lea rax, [wNum]
	mov rax, [wNum]
	lea rax, [text1]
	mov rax, text1
	mov rax, text1 + 1
	lea rax, [text1 + 1]
	mov rax, [text1]
	mov rax, [text1 + 1]
	mov rsp, rbp
	pop rbp
	ret

	
