#include <stdio.h>

extern float stozek(unsigned int big_r, unsigned int small_r, float h);



void main() {


	float a = stozek(7, 3, 4.2);

	printf("%f\n", a);
}