#include <stdio.h>

extern void func(int* big, int* small, int tab[], int size);


void main() {

	int big;
	int small;
	int tab[] = {-1, 1 ,2 , -2 , 3 , -1000, 250000, 80, -2, -4};


	func(&big, &small, tab, sizeof(tab) / sizeof(int));

	printf("big = %d small = %d", big, small);
}