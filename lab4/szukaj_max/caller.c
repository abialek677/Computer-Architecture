#include <stdio.h>

extern __int64 szukaj64_max(__int64* tab, __int64 n);


int main() {

	__int64 tab[] = { -15, 4000000, -345679, 88046592,-1, 2297645, 7867023, -19000444, 31,-456000000000000,444444444444444,-123456789098765 };

	__int64 max = szukaj64_max(tab, sizeof(tab) / sizeof(__int64));

	printf("Max = %I64d\n", max);

}