.686
.model flat

public _func


.code

;extern void func(int* big, int* small);

_func PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

mov eax, [ebp + 16] ; adres pierwszego elementu
mov ecx, [ebp+20] ; counter wszystkich elementow


mov ebx, 7FFFFFFFH ; max storing min
mov edx, 80000000H ; min storing max

ptl:
cmp [eax], edx
jg bigger
cmp [eax], ebx
jl smaller



add eax, 4
loop ptl
jmp koniec

smaller:


mov ebx, [eax]


jmp ptl

bigger:

mov edx, [eax]



jmp ptl


koniec:

mov eax,[ebp+8]
mov [eax], edx
mov eax, [ebp+12]
mov [eax], ebx

pop esi
pop edi
pop ebx
pop ebp
ret
_func ENDP
END