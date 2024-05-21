.686
.model flat



public _nowy_exp

.data
x dd ?
;suma dd 0.0

.code
;extern float nowy_exp(float x);
_nowy_exp PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi


mov ebx, [ebp+8]

mov x,ebx

finit

mov ecx, 19
mov edi, 1
;fld suma
fldz
ptl:
mov esi, 1
fld x
push esi
fild dword ptr [esp]
add esp, 4
; 0 = 1		1 = x		2 = suma
licz:
cmp edi, esi
je dalej
fld x
fmul st(2), st(0)
fstp st(0)
inc esi
push esi
fimul dword ptr [esp]
add esp, 4
jmp licz
dalej:
; 0 = 1*2*3...	1 = x^...	2 = suma
fdiv
faddp st(1), st(0)
inc edi
dec ecx
jecxz koniec
jmp ptl
koniec:
mov eax, 1
push eax
fild dword ptr [esp]
add esp, 4
fadd ;faddp st(1), st(0)


pop esi
pop edi
pop ebx
pop ebp
db 0c3h
_nowy_exp ENDP
END