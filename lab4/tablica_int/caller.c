#include <stdio.h>

extern unsigned int* convert(char* tekst);
int piec = 5;



int main() {
	char a[255];

	scanf_s("%254[^\n]", a,254);


	int* tab;
	tab = convert(a);


	return 0;
}