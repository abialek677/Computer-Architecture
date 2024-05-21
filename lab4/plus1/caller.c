#include <stdio.h>


extern void plus1(int* a);

int main() {

	int m = -5;

	plus1(&m);

	printf("\n m = %d", m);




	return 0;
}