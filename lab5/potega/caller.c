#include <stdio.h>


extern float power(int num, int pow);



void main() {


	float a;

	for (int i = -10; i <= 10; i++) {
		a = power(2, i);

		printf("6 do potegi %d = %f\n\n", i, a);
	}



}
