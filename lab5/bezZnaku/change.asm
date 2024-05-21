.686
.model flat

public _uint48_float

.data
dziesiec dd 10

.code
;extern float uint48_float(UINT48 p);
_uint48_float PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

mov ebx, [ebp+12] ; czesc calkowita
mov ax, [ebp+8]

movzx eax, ax
finit
; w eax czesc ulamkowa, w ebx czesc calkowita
push eax
fild dword ptr [esp]
add esp, 4

fldz
ptl:
	fstp st(0)
	fild dziesiec
	fdiv
	fld1
	fcomi st(0), st(1)
jb ptl

fstp st(0)
push ebx
fild dword ptr [esp]
add esp, 4
fadd

pop esi
pop edi
pop ebx
pop ebp
ret
_uint48_float ENDP
END