%define O_RDONLY 0
%define PROT_READ 0x1
%define MAP_PRIVATE 0x2

section .data
fname: db 'test.txt', 0

section .text
global _start

print_string:
	push rdi
	call string_length
	pop rsi
	mov rdx, rax
	mov rax, 1
	mov rdi, 1
	syscall
	ret

string_length:
	xor rax, rax

.loop:
	cmp byte [rdi + rax], 0
	je .end
	inc rax
	jmp .loop

.end:
	ret

_start:
	; call open to read the file
	mov rax, 2 ; open file syscall num
	mov rdi, fname
	mov rsi, O_RDONLY ; open read only mode
	mov rdx, 0

	syscall

	; mmap syscall
	mov r8, rax    ; rax has open fd, save it

	mov rax, 9 ;mmap syscall num
	mov rdi, 0 ;OS will choose map dest, don't give memory address
	mov rsi, 4096 ; page size
	mov rdx, PROT_READ ; read only memory
	mov r10, MAP_PRIVATE ; pages will not be shared

	mov r9, 0 	;offset inside test.txt
	syscall

	mov rdi, rax
	call print_string

	mov rax, 60
	xor rdi, rdi
	syscall
