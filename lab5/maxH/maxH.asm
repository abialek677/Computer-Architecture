.686
.model flat

public _maxH

.data
g dd 9.81

.code

;extern float maxH(float v, float alpha);
_maxH PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi


finit
fld dword ptr [ebp+12] ; alpha zaladowana
fldpi
mov eax, 180
push eax
fild dword ptr [esp]
add esp, 4
;st(0) = 180 1 = pi 2 = alpha
fdiv
fmul
fsin
fst st(1)
fmul
fld dword ptr [ebp+8]
fld dword ptr [ebp+8]
fmul
fmul  ;obliczona gora ulamka
fld g
fld g
fadd
fdiv


pop esi
pop edi
pop ebx
pop ebp
ret
_maxH ENDP
END