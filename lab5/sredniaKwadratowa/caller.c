#include <stdio.h>

extern float quad(float* tab, int n);



void main() {

	float tab[] = { 1,2,3,4,5,6 };

	float a = quad(tab, 6);

	printf("wynik = %f", a);

}