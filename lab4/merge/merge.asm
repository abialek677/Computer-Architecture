.686
.model flat

public _merge
extern _malloc : PROC
.code

_merge PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi


mov ebx, [ebp+8]; adres tab1
mov ecx, [ebp+16]; liczba elem 1 tab

imul ecx, 2
cmp ecx, 32
jbe dalej
jmp koniec

dalej:
imul ecx, 4
push ecx
call _malloc
add esp, 4
mov edx, eax ;przechowanie adresu tablicy w edx
; w eax jest adres tablicy w ktora bede wpisywal
;mov esi, ecx ; punkt startowy po skonczeniu tab1
mov ecx, [ebp+16]
mov edi, 0
ptl1:
	mov esi, [ebx+4*edi]
	mov [eax+4*edi], esi
	inc edi
loop ptl1
mov ecx, [ebp+16]
mov ebx, [ebp + 12]
mov edx, edi
mov edi, 0
ptl2:
	mov esi, [ebx+4*edi]
	mov [eax+4*edx], esi
	inc edx
	inc edi
loop ptl2

koniec:
pop esi
pop edi
pop ebx
pop ebp
ret
_merge ENDP
END