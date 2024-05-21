#include <stdio.h>

extern void waga(int n, int m, double* N, double* W);


void main() {
	int n = 3;
	int m = 2;
	
	// double* N = (double*)malloc(sizeof(double) * m * n);
	//double* W = (double*)malloc(sizeof(double) * n);
	double N[6];
	double W[3];

	/*for (int i = 0; i < 9; i++) {
		N[i] = i;
	}*/

	N[0] = 0;
	N[1] = 1;
	N[2] = 3;
	N[3] = 4;
	N[4] = 6;
	N[5] = 7;

	waga(n, m, N, W);

	for (int i = 0; i < 3; i++) {

		printf("%lf ", W[i]);

	}
	float sum = W[1] + W[2] + W[0];
}