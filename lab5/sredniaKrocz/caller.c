#include <stdio.h>

extern float progowanie_sredniej_kroczacej(float* tab, unsigned int k, unsigned int m);

void main() {
	float tab[] = { 1,2,3,4,5,6,7,7,9 };

	float a = progowanie_sredniej_kroczacej(tab, 9, 2);

	printf("Wynik = %f\n", a);
}