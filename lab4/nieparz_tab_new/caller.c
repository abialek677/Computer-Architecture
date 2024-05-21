#include <stdio.h>

extern int* tablica_nieparzystych(int tablica[], unsigned int* n);


int main() {

	int* a;
	int tab[] = { 1,2,3,4,5,6,7,8,9,10,11,12,13 };
	int n = 13;

	a = tablica_nieparzystych(tab, &n);

	if (&a == 0)
		return 0;

	for (int i = 0; i < n; i++) {
		printf("%d ", a[i]);
	}
	return 0;
}