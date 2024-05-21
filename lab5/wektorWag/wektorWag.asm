.686
.model flat

public _waga

.data
przeskokWiersz dd 8
dzielnik dq ?

.code
;extern void waga(int n, int m, double* N, double* W);
_waga PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi
finit
mov eax, [ebp+12]
mul przeskokWiersz
mov przeskokWiersz, eax ; odpowiednia wartosc w przeskok wiersz

mov ebx, [ebp+16] ; adres macierzy
mov edi, [ebp+12]
mainPtl:
mov esi, 0
fldz
mov ecx, [ebp+8]
ptl1:
fld qword ptr [ebx+esi]
fadd
add esi, przeskokWiersz
loop ptl1
mov ecx, [ebp+8]
mov esi, 0
fstp dzielnik
ptl2:
fld qword ptr [ebx+esi]
fld dzielnik
fdiv
fstp qword ptr [ebx+esi]
add esi, przeskokWiersz
loop ptl2
add ebx, 8
dec edi
cmp edi, 0
jne mainPtl

; macierz zmodyfikowana
mov edx, [ebp+8]; iteracje final loopa (n)
mov ebx, [ebp+16];adres zmodyfikowanej macierzy
mov eax, [ebp+20]; adres macierzy wynikowej
finalLoop1:
mov ecx, [ebp+12] ;iteracje wewnatrz jednego wiersza (m)

fldz
finalLoop2:
fld qword ptr [ebx]
fadd
add ebx, 8
loop finalLoop2


fild dword ptr [ebp+12]
fdiv

fstp qword ptr [eax]
add eax, 8
dec edx
cmp edx, 0
jne finalLoop1

pop esi
pop edi
pop ebx
pop ebp
ret
_waga ENDP
END