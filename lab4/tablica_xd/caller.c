#include <stdio.h>

extern int* tablica(int a);



int main() {

	int *a, b;
	b = 4;
	a = tablica(b);

	for (int i = 0; i < b; i++) {
		printf("%d ", a[i]);
	}

	return 0;
}