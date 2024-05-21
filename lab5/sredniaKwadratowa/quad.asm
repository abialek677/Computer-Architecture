.686
.model flat

public _quad



.code
;extern float quad(float* tab, int n);
_quad PROC
push ebp
mov ebp, esp
push ebx
push esi
push edi

mov ebx, [ebp+8];adres tablicy floatow
mov ecx, [ebp+12]; n

finit
fldz

ptl:
fld dword ptr [ebx]
fld dword ptr [ebx]
fmul
fadd
add ebx, 4
loop ptl
fild dword ptr [ebp+12]
fdiv
fsqrt


pop edi
pop esi
pop ebx
pop ebp
ret
_quad ENDP
END