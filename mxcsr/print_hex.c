#include <stdio.h>

void print_hex(unsigned char c)
{
	if (c < 16)
		printf("0");
	printf("%x", c);
}
