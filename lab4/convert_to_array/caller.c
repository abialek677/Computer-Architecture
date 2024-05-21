#include <stdio.h>

unsigned long long* convert(char* text);



void main() {

	unsigned int* a;

	char tab[255];
	scanf_s("%254[^\n]", tab, 255);

	a = convert(tab);

	for (int i = 0; i < 3; i++) {
		printf("%lld ", a[i]);
	}


}