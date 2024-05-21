#include <stdio.h>

extern short __stdcall suma(short a, short b);

void main() {

	short a = suma(1, 2);

	printf("%hd\n", a);

}