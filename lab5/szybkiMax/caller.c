#include <stdio.h>
#include <xmmintrin.h>

extern __m128 fastMax(short int tab1[], short int tab2[]);


void main() {

	short int tab1[] = { 1,-1,2,-2,3,-3,4,-4 };
	short int tab2[] = { -4,-3,-2,-1,0,1,2,3 };

	__m128 t1 = fastMax(tab1, tab2);

	int a = 0;


}