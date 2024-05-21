#include <stdio.h>

extern int* merge(int tab1[], int tab2[], int n);

int main() {
	int size;
	scanf_s("%d", &size);

	int* tab1;
	int* tab2;

	tab1 = (int*)malloc(size * sizeof(int));
	tab2 = (int*)malloc(size * sizeof(int));

	int num;
	printf("Podaj tab 1: \n");
	for (int i = 0; i < size; i++) {
		scanf_s("%d", &num);
		tab1[i] = num;
	}
	printf("Podaj tab 2: \n");
	for (int i = 0; i < size; i++) {
		scanf_s("%d", &num);
		tab2[i] = num;
	}

	int* a;
	a = merge(tab1, tab2, size);

	for (int i = 0; i < size * 2; i++) {
		printf("%d ", a[i]);
	}
	return 0;
}