.686
.model flat


;extern short int dodaj(wchar_t liczba[], char cyfra, wchar_t** wynik);
public _dodaj
extern _malloc : PROC

.code

_dodaj PROC
push ebp
mov ebp, esp
push ebx
push esi
push edi


mov ebx, [ebp+12]; char
;xchg bl,bh ;changed to wchar

push dword ptr 24
call _malloc
add esp, 4
mov ecx, [ebp +16]
mov [ecx], eax


mov ecx, eax ; adres wyniku w tablicy
add ecx, 2

mov esi, 0
mov edx, [ebp+8]; adres tablicy
ptl_count:
	inc esi
	cmp word ptr [edx+2*esi-2], 0
jne ptl_count
sub esi, 2

mov edi, 0
mov di, [edx+2*esi]
add di, bx
cmp di, 69h
jle finish


sub di, 3Ah
mov [ecx+2*esi], di
mov di, [edx+2*esi-2]
add di, 1h
carry:
	cmp di, 39h
	jbe carryEnd
	sub di, 0Ah
	mov [ecx+2*esi-2], di
	dec esi
	mov di, [edx+2*esi-2]
	add di, 1h
	cmp esi, 0
	jne carry

	sub ecx, 2
	mov [ecx], word ptr 31h

	jmp koniec


	carryEnd:
	mov [ecx+2*esi-2], di
	carryEnd2:
	dec esi
	mov di, [edx+2*esi-2]
	mov [ecx+2*esi-2], di
	cmp esi, 0
	jne carryEnd2
	jmp koniec

finish:
sub di, 30h
mov [ecx+2*esi], di
finish2:
mov di, [edx+2*esi-2]
mov [ecx+2*esi-2], di
dec esi
cmp esi, 0
jne finish2



koniec:

pop edi
pop esi
pop ebx
pop ebp
ret
_dodaj ENDP
END