prime: isprime.o
	ld -o isprime isprime.o

isprime.o: isprime.asm
	nasm -felf64 isprime.asm -Fdwarf

clean:
	rm ./isprime.o ./isprime
