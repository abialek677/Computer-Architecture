#include <stdio.h>
#include <Windows.h>

extern wchar_t* convert_to_bin(unsigned long long liczba);


int main() {


	
	
	wchar_t* a;
	a = convert_to_bin(5000000000);
	
	MessageBox(0, a, 0, 0);
	
	return 0;
}