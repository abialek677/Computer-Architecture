.686
.model flat

public _minElem

.code

;extern int* minElem(int tab[], int n);
_minElem PROC
push ebp
mov ebp, esp
push ebx
push esi

mov ebx, [ebp+8] ;adres tablicy
mov ecx, [ebp+12] ;liczba znakow
mov edx, 7FFFFFFFh ; max
mov esi, 0

ptl:
	inc esi
	cmp edx, [ebx+esi*4-4]
	jg change
	cmp esi, ecx
	jne ptl
	jmp koniec


change:
	mov edx, [ebx+esi*4-4]
	lea eax, [ebx+esi*4-4]
	cmp esi, ecx
	jne ptl

koniec:
pop esi
pop ebx
pop ebp
ret
_minElem ENDP
END