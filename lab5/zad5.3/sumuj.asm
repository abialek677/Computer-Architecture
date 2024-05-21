.686
.XMM
.model flat


public _suma



.code
;extern void suma(char* tab1, char* tab2, int* wynik);
_suma PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

mov esi, [ebp+8] ; adres tab1
mov edi, [ebp+12] ; adres tab2
mov ebx, [ebp+16] ; adres wynikowej tablicy

movups xmm5, [esi]
movups xmm6, [edi]


paddsb xmm5,xmm6

movups [ebx], xmm5














pop esi
pop edi
pop ebx
pop ebp
ret
_suma ENDP
END