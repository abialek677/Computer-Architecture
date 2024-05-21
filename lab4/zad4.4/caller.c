#include <stdio.h>

extern void swap(int tab[], int n);



int main() {

	int tab[] = { 2,1,4,3,6,5,7 };

	

	for (int i = sizeof(tab) / sizeof(int); i != 0; i--) {
		swap(tab, i);
		printf("wynik = ");
		for (int j = 0; j < sizeof(tab) / sizeof(int); j++) {
			printf("%d ", tab[j]);
		}
		printf("\n");
	}


	return 0;
}