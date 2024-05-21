.686
.model flat




public _convert_to_bin
extern _malloc : PROC

.code

;extern wchar_t* convert_to_bin(unsigned long long liczba) ; starszy na +12 mlodszy +8
_convert_to_bin PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

mov ebx, [ebp+8] ;mlodsza czesc liczby


push dword ptr 130
call _malloc
add esp, 4
mov edi, eax ;adres do zwrotu



mov edx, edi
add edx, 128
mov [edx], word ptr 0
sub edx, 2
mov ecx, 32
ptl:
	shr ebx, 1
	jc jeden
	mov [edx], word ptr '0'
	sub edx, 2
loop ptl
jmp skok1
jeden:
	mov [edx], word ptr '1'
	sub edx, 2
loop ptl

skok1:
	mov ecx, 32
	mov ebx, [ebp+12]
ptl1:
	shr ebx, 1
	jc jeden2
	mov [edx], word ptr '0'
	sub edx, 2
loop ptl1
jmp skok2
jeden2:
	mov [edx], word ptr '1'
	sub edx, 2
loop ptl1

skok2:



koniec:

mov eax, edi
pop esi
pop edi
pop ebx
pop ebp
ret
_convert_to_bin ENDP
END