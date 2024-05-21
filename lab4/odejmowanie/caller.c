#include <stdio.h>


extern int odejmowanie(int** odjemna, int* odjemnik);

int main() {
	int a, b, * wsk, wynik;
	wsk = &a;

	a = 21;
	b = 25;

	wynik = odejmowanie(&wsk, &b);

	printf("wynik odejmowania %d - %d = %d\n", a, b, wynik);

	return 0;
}