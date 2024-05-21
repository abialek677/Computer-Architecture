#include <stdio.h>

extern float nowy_exp(float x);


void main() {

	float x;
	scanf_s("%f", &x);

	float res = nowy_exp(x);

	printf("Result = %f\n", res);
}