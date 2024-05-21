#include <stdio.h>


extern unsigned int fibonaci(int n);



void main() {

	unsigned int a = fibonaci(47);

	printf("%u\n", a);
}