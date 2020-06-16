prime: isprime.o
	ld -o isprime isprime.o

isprime.o:
	nasm -felf64 isprime.asm -Fdwarf

clean:
	rm ./isprime.o ./isprime
