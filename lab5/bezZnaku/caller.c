#include <stdio.h>

typedef struct {

	short ulam;
	int calk;
} UINT48;



extern float uint48_float(UINT48 p);



void main() {

	UINT48 a;
	a.calk = 7;
	a.ulam = 11;

	float ret = uint48_float(a);

	printf("wynik = %f", ret);
}

