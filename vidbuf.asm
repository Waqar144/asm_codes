section .data
	EOL equ 10
	FILLCHR equ 10
	HBARCHR equ 196
	STRTROW equ 2

	Dataset db 9,71,17,52,55,18,29,36,18,68,77,63,58,44,0

	Message db "Data current as of 5/13/2009"
	MSGLEN 	equ $-Message

	ClrHome db 27,"[2J",27,"[01;01H"
	CLRLEN  equ $-ClrHome

section .bss
 	
	COLS equ 81
	ROWS euq 25
	VidBuf resb COLS * ROWS

section .text
	global main

	%macro ClearTerminal 0
		pushad
		mov rax, 1 ;sys_write
		mov rdi, 1 ;stdout
		mov rsi, ClrHome ;buf
		mov rdx, CLRLEN ;len
		int 80h
		popad
	%endmacro

Show:
	pushad
	mov rax, 1
	mov rdi, 1
	mov rsi, VidBuf
	mov rdx, COLS * ROW
	int 80h
	popad

ClrVid:
	push rax
	push rcx
	push rdi

	cld ; clear df
	mov al, FILLCHR
	mov rdi, VidBuf
	mov rcx, COLS * ROWS
	rep stosb

	;  buffer is cleared, now we need to reinsert the EOL char after each line
	mov rdi, VidBuf
	dec rdi
	mov rcx, COLS

PutEOL:
	add rdi, COLS
	loop PtEOL
	pop rdi
	pop rcx
	pop rax
	ret

WriteLn:
	push rax
	push rbx
	push rcx
	push rdi
	cld
	mov rdi, VidBuf
	dec rax
	dec rbx
	mov ah, COLS
	mul ah
	add rdi, rax
	add rdi, rbx
	rep movsb
	pop rdi
	pop rcx
	pop rbx
	pop rax
	ret

WriteHb:
	push rax
	push rbx
	push rcx
	push rdi
	cld ; clear df for up memory write
	mov rdi, VidBuf
	dec rax
	dec rbx
	mov ah, COLS
	add rdi, rax
	add rdi, rbx
	mov al, HBARCHR
	rep stosb
	pop rdi
	pop rcx
	pop rbx
	pop rax
	ret

Ruler:
	push rax
	push rbx
	push rcx
	push rdi
	mov rdi, VidBuf
	dec rax
	dec rbx
	mov ah, COLS
	mul ah
	add rdi, rax
	add rdi, rbx

	mov al, '1'

DoChar:
	stosb
	add al, '1'
	aaa
	add al, '0'
	loop DoChar
	pop rdi
	pop rcx
	pop rbx
	pop rax
	ret

main:
	push rbp
	mov rbp, rsp

	ClearTerminal
	call ClrVid

	; display top ruler
	mov rax, 1
	mov rbx, 1
	mov rcx, COLS-1
	call Ruler

	;graph the data
	mov rsi, Dataset
	mov rbx, 1
	mov r10, 0
.blast:
	mov rax, r10
	add rax, STRTROW
	mov cl, byte[rsi + r10]
	cmp rcx, 0
	je .rule2
	call WriteHb
	inc r10
	jmp .blast

.rule2:
	mov rax, r10
	add rax, STRTROW
	mov rbx, 1
	mov rcx, COLS - 1
	call Ruler

	mov rsi, Message
	mov rcx, MSGLEN
	mov rbx, COLS
	sub rbx, rcx
	shr rbx, 1
	mov rax, 24
	call WriteLn

	call Show

	leave
	ret




