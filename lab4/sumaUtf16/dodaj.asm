.686
.model flat


public _dodaj
extern _malloc : PROC


.code
;extern short int dodaj(wchar_t liczba[], char cyfra, wchar_t** wynik);
_dodaj PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

mov ebx, [ebp+8];adres tablicy liczby
mov edi, [ebp+12]; cyfra do dodania jako char
sub edi, 30h ;liczba do dodania

push ebx
call int_eax
add esp, 4

add eax, edi

mov edi, eax
push dword ptr 24
call _malloc
add esp, 4
xchg edi, eax ;w eax liczba, w edi adres
mov edx, [ebp+16]
mov [edx], edi

mov ebx, 10 ;mnoznik
mov esi, 0
konwersja:
	mov edx, 0
	div ebx
	add edx, 30h
	mov [edi+esi*2], dx
	inc esi
	cmp eax, 0
	jne konwersja

mov word ptr [edi+esi*2],0



pop esi
pop edi
pop ebx
pop ebp
ret
_dodaj ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
int_eax PROC
push ebp
mov ebp,esp
push ebx
push ecx

mov ebx, [ebp+8];adres tablicy
mov eax, 0


mov ecx, 0
ptlint:
	mov cx, [ebx]
	add ebx, 2
	cmp cx, 0
	je koniecc
	imul eax, 10
	add eax, ecx
	sub eax, 30H
jmp ptlint

koniecc:

pop ecx
pop ebx
pop ebp
ret
int_eax ENDP
END