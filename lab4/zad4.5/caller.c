#include <stdio.h>


extern __int64 suma_siedmiu_liczb(__int64 v1, __int64 v2, __int64 v3, __int64 v4, __int64 v5, __int64 v6, __int64 v7, __int64 v8);


int main() {

	int suma = suma_siedmiu_liczb(1, 2, 3, 4, 5, 6, 7,8);

	printf("Suma liczb = %I64d\n",suma);


	return 0;
}