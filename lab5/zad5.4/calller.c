#include <stdio.h>

extern void int2float(int* calkowite, float* zmienno_przec);


void main() {

	int a[2] = { -17, 24 };
	float r[4];
	// podany rozkaz zapisuje w pami�ci od razu 128 bit�w,
	// wi�c musz� by� 4 elementy w tablicy
	int2float(a, r);
	printf("\nKonwersja = %f %f\n", r[0], r[1]);
}