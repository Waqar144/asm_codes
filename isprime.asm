section .data

primestr: db "Prime", 10, 0

notprimestr: db "Not prime", 10, 0

primestr_len equ $-primestr
notprimestr_len equ $-notprimestr

section .text
global _start

dividebytwo:
    mov rdx, 0 ; clear dividend
	mov rax, rdi ;argument is in rdi
	mov rcx, 2 ; divide by 2
	div rcx
	;rax now has the final value
	
	ret

is_prime:
	push rdi

	call dividebytwo ; divide by 2

	;rax has now the value
	;rdi has the number

	;decrement rax by 1
	;num % rax
	;if result is 0
	;not prime
	;else if we reach 0
	;prime

	;use the r11 register for decrementing
	push r11
	mov r11, rax
xloop:
	xor rdx, rdx

	mov r10, r11; divisor
	mov rax, rdi ; put number into rax
	div r10

	dec r11
	cmp r11, 0
	jz prime_endloop

	;check if rdx is 0, if it is zero, this is not a prime
	;else loop again
	cmp rdx, 0
	jnz xloop

	;number not prime
	mov rax, 0
	ret

prime_endloop:
	;number is prime
	mov rax, 1
	
	pop r11
	pop rdi

	ret

_start:

	mov rdi, 17

	call is_prime

	cmp rax, 1
	jz Print_prime

;there's probably better ways to do this xD

Print_notprime:
	mov rax, 1 ;sys_write
	mov rdi, 1
	mov rsi, notprimestr
	mov rdx, notprimestr_len
	syscall
	jmp exit

Print_prime:

	mov rax, 1 ;sys_write
	mov rdi, 1
	mov rsi, primestr
	mov rdx, primestr_len
	syscall

exit:
	mov rax, 60
	xor rdi, rdi
	syscall
