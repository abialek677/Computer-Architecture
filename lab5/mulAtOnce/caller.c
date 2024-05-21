#include <stdio.h>
#include <xmmintrin.h>

extern __m128 mul(__m128 one, __m128 two);

void main() {

	__m128 one;
	__m128 two;

	for (int i = 1; i <= 4; i++) {
		one.m128_i32[i - 1] = i;
		two.m128_i32[i - 1] = i+5;
	}

	__m128 ret = mul(one, two);
	for (int i = 0; i < 4; i++) {
		printf("%d \n", ret.m128_i32[i]);
	}
}