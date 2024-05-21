#include <stdio.h>

extern int* minElem(int tab[], int n);



int main() {
	int tab[] = { 1,2,3,4,-8,-2 };
	int* wsk;
	wsk = minElem(tab, 6);

	printf("wynik = %d\n", *wsk);
	return 0;
}