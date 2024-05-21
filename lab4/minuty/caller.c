#include <stdio.h>

extern int minutes();


int main() {

	int mins = minutes();

	printf("current mins = %d", mins);

	return 0;
}