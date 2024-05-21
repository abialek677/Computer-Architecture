.686
.model flat

public _single_neuron
extern _malloc : PROC

.code
;extern float* single_neuron(double* x, float* w, unsigned int n);

_single_neuron PROC
push ebp
mov ebp, esp
push ebx
push esi
push edi
finit

mov ebx, [ebp+8]
mov edx, [ebp+12]
mov ecx, [ebp+16]

fld1
fld dword ptr [edx]
fmul
add edx, 4
ptl:
fld qword ptr [ebx]
fld dword ptr [edx]
fmul
fadd
add ebx, 8
add edx, 4
loop ptl

push 4
call _malloc
add esp, 4


fldz
fcomi st(0), st(1) ;st0 = 0		st1 = liczba
ja zeroGreater
fstp st(0)
zeroGreater:
fst dword ptr [eax]



pop edi
pop esi
pop ebx
pop ebp
db 0c3h
_single_neuron ENDP
END