.686
.model flat

public _tablica
extern _malloc : PROC

.code

;extern int tablica(int a);
_tablica PROC
push ebp
mov ebp, esp
push edi
push esi

mov ecx, [ebp + 8] ;parametr

imul ecx, 4
push ecx
call _malloc
add esp, 4



mov ecx, [ebp + 8] ;parametr
mov edi, 0
mov esi, 0
ptl:
	imul esi, edi, 3
	dec esi
	mov [eax+edi*4], esi
	inc edi
loop ptl


pop esi
pop edi
pop ebp
ret
_tablica ENDP
END
