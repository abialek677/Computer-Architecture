#include <stdio.h>

extern int wyszukaj(wchar_t tab[], wchar_t* znak, int* wystepowanie, short a);



int main() {
	wchar_t utf16[] = L"Hello, 世世世界!";
	wchar_t znak = L'世';
	int a = 0;

	int n = wyszukaj(utf16, &znak, &a, 10);

	printf("%d\n%d", n, a);

	return 0;
}