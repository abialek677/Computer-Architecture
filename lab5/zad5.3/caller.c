#include <stdio.h>


extern void suma(char* tab1, char* tab2, char* wynik);


void main() {

	char liczby_A[16] = { -128, -127, -126, -125, -124, -123, -122, -121, 120, 121, 122, 123, 124, 125, 126, 127 };

	char liczby_B[16] = { -3, -3, -3, -3, -3, -3, -3, -3, 3, 3, 3, 3, 3, 3, 3, 3 };

	char ret[16];
	suma(liczby_A, liczby_B, ret);

	for (int i = 0; i < 16; i++) {
		printf("%d ", ret[i]);
	}

}