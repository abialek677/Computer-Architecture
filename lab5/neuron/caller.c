#include <stdio.h>

extern float* single_neuron(double* x, float* w, unsigned int n);

void main() {
	double tab1[] = { 2,3,4,5,-6 };
	float tab2[] = {1,2,3,4,5,6 };
	unsigned int n = 5;


	float* a = single_neuron(tab1, tab2, n);
	float b = *a;

	printf("Wynik = %f\n", b);

}