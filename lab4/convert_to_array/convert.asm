.686
.model flat

public _convert
extern _malloc : PROC

.data
dziesiec dd 10

.code
;unsigned int* convert(char* text);
_convert PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi



mov ebx, [ebp+8];adres na pierwszy znak tablicy

push dword ptr 510
call _malloc
add esp, 4

mov esi, eax

push eax
mov eax, 0
ptl1:
mov cl, [ebx]
		inc ebx

		cmp cl,20h
		je spacja
		
		sub cl, 30h
		movzx ecx, cl
		;mnozenie przez 10
		mov edi, eax

		
		shl eax, 1
		rcl edx, 1

		shl eax, 1
		rcl edx, 1

		shl eax, 1
		rcl edx, 1

		push ebx
		mov ebx, 0

		shl edi, 1
		rcl ebx, 1



		add eax, edi
		adc edx, ebx

		;mul dword ptr dziesiec
		add eax, ecx
		adc edx,0
		pop ebx


	add eax, ecx
jmp ptl1

spacja:
	mov [esi], eax
	mov eax, 0
	add esi, 4
	mov [esi], edx
	mov edx, 0
	add esi,4
jmp ptl1


koniec:


mov [esi], eax

pop eax


pop esi
pop edi
pop ebx
pop ebp
ret
_convert ENDP
END