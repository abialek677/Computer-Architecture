#include <stdio.h>

extern int szukaj_max4(int a, int b, int c, int d);


int main() {

	int wynik = szukaj_max4(-400,-300,-200,-100);

	printf("%d\n", wynik);


	return 0;
}