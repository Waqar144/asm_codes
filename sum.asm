section .bss
inp resb 255

section .text
global _start

_start:
    mov eax, 3 ;sys_read
    mov ebx, 0 ;stdin
    mov ecx, inp ;read into inp
    mov edx, 255 ;no of bytes to read
    int 0x80

	mov eax, 1
	int 80h

    xor rax, rax
    ret
