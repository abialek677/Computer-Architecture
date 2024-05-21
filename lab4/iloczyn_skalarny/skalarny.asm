.686
.model flat

public _dot_product

.code
;extern int dot_product(int tab1[], int tab2[], int n);
_dot_product PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

mov ebx, [ebp+8] ;adres tab1
mov edx, [ebp+12] ;adres tab2
mov ecx, [ebp + 16]; rozmiar jednej tablicy

mov eax, 0
mov edi, 0

ptl:
	 mov esi, [ebx+4*edi]
	 imul esi, [edx+4*edi]
	 add eax, esi
loop ptl





pop esi
pop edi
pop ebx
pop ebp
ret
_dot_product ENDP
END