#include <stdio.h>

extern float srednia_harm(float* tablica, unsigned int n);


void main() {
	int n;

	scanf_s("%u", &n);

	float* tab = (float*)malloc(n * sizeof(float));

	for (int i = 0; i < n; i++) {
		scanf_s("%f", &tab[i]);
	}

	float avg = srednia_harm(tab, n);


	printf("Srednia harm = %f", avg);
	
}