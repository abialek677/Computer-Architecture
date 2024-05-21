.686
.model flat

public _convert
extern _malloc : PROC
extern _piec : DWORD

.code

_convert PROC
push ebp
mov ebp, esp
push ebx

mov ebx, [ebp+8] ;adres tablicy


mov eax, _piec










pop ebx
pop ebp
ret
_convert ENDP
END