#include <stdio.h>

extern void negative_num(int* a);


int main() {

	int m = 5;


	negative_num(&m);

	printf("m po negacji: %d", m);


	return 0;
}