#include <stdio.h>

extern short int dodaj(wchar_t liczba[], char cyfra, wchar_t** wynik);

int main() {
	wchar_t liczba[] = L"999999999";
	wchar_t* wynik;
	short int a;
	a = dodaj(liczba, '2', &wynik);

	printf("\nwynik = %ls\n", wynik);




	return 0;
}