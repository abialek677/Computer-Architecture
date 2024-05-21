.686
.model flat


.code
;extern float stozek(unsigned int big_r, unsigned int small_r, float h);

_stozek PROC
push ebp
mov ebp, esp
push ebx
push esi
push edi

finit
fild dword ptr [ebp+8]
fild dword ptr [ebp+8] 
fmul					; R^2
fild dword ptr [ebp+8]
fild dword ptr [ebp+12]
fmul					; rR
fild dword ptr [ebp+12]
fild dword ptr [ebp+12]
fmul					; r^2
fadd
fadd					; st(0) = nawias
fld1
mov eax, 3
push eax
fild dword ptr [esp]
add esp, 4
fdiv					;st(0) = 1/3	st(1) = nawias
fldpi
fld	dword ptr [ebp+16]
fmul
fmul
fmul


pop edi
pop esi
pop ebx
pop ebp
ret
_stozek ENDP
END