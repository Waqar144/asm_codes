sse_unaligned: sse_unaligned.o
	gcc -o sse_unaligned sse_unaligned.o -no-pie
sse_unaligned.o: sse_unaligned.asm
	nasm -f elf64 -g -F dwarf sse_unaligned.asm
clean:
	rm -rf *.o ./sse_unaligned
