#include <stdio.h>

extern float* matrix(double* A, int* B, unsigned int k, unsigned int l, unsigned int m);



void main() {

	double tab1[12] = {1,2,3,4,5,6,7,8,9,10,11,12};
	int tab2[12] = { 1,2,3,4,5,6,7,8,9,10,11,12 };
	
	float* a = matrix(tab1, tab2, 3, 4, 3);

	int j = 0;
	for (int i = 0; i < 9; i++) {
		printf("%f ", a[i]);
		if (j >= 2) {
			j = -1;
			printf("\n");
		}
		j++;
	}


}