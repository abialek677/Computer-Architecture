.686
.model flat

public _tablica_nieparzystych
extern _malloc : PROC

.code


;extern int* tablica_nieparzystych(int tablica[], unsigned int* n);
_tablica_nieparzystych PROC
push ebp
mov ebp, esp
push ebx
push esi
push edi

mov esi, 0; licznik nieparzystych
mov ebx, [ebp+8] ;adres tablicy
mov edx, [ebp + 12] ;adres zmiennej n do zmiany potem
mov ecx, [edx] ;liczba elementow
mov edi, ecx
;dec ecx
ptl1:
	test dword ptr [ebx+4*ecx-4],1
	jnz nieparz
	loop ptl1
	jmp skok

nieparz:
	inc esi
	loop ptl1

skok:
mov [edx], esi
push esi
call _malloc
add esp,4

;mov edx, eax; adres nowej tablicy zapisany w edx

mov ecx, edi; przywrocenie liczby elementow pierwszej tablicy

mov edi, 0
mov esi, 0

ptl2:
	test dword ptr[ebx+4*edi], 1
	jnz nieparz2
	inc edi
	cmp edi, ecx
	je koniec

nieparz2:
	mov edx, [ebx+4*edi]
	mov [eax+esi*4], edx
	inc esi
	inc edi
	cmp edi, ecx
	je koniec
	jmp ptl2





koniec:
pop edi
pop esi
pop ebx
pop ebp
ret
_tablica_nieparzystych ENDP
END