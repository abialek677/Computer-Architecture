.686
.model flat



public _wyszukaj


.code


;wyszukaj(wchar_t tab[], wchar_t* znak, int* wystepowanie, char a);
_wyszukaj PROC
push ebp
mov ebp, esp
push ebx
push esi
push edi



mov ebx, [ebp+8] ; adres tablicy
mov esi, [ebp+12] ; adres znaku
mov si, [esi] ; znak
and esi, 0000FFFFh
mov edx, [ebp+16] ; adres inta

mov eax, 0 ; wystapienia
mov edi, 0 ; pierwsze wystapienie

mov ecx, 0 ; iterator

ptl:
	cmp [ebx+2*ecx], si
	je znak
	cmp word ptr [ebx+2*ecx], 0
	je koniec
	inc ecx
	jmp ptl


znak:
	cmp eax, 0
	je pierwszy
	inc eax
	inc ecx
jmp ptl





koniec:
dec eax ; wczesniej przez element znak dodales 2 razy
pop edi
pop esi
pop ebx
pop ebp
ret

pierwszy:
	inc eax
	mov [edx], ecx
jmp znak
_wyszukaj ENDP
END