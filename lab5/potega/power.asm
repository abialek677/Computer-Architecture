.686
.model flat


public _power
.data



.code
;extern float power(int num, int pow);
_power PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

finit

mov ecx, [ebp+12] ; wykladnik
cmp ecx, 0
je wyjatek

bt ecx, 31
jnc dodatniaPotega

neg ecx
fld1
fild dword ptr [ebp+8]
fdiv
fst dword ptr [ebp+8]
licz1:
dec ecx
cmp ecx, 0
je koniec

fld dword ptr [ebp+8]
fmul
jmp licz1


dodatniaPotega:
fild dword ptr [ebp+8]
licz2:
dec ecx
cmp ecx, 0
je koniec
fild dword ptr [ebp+8]
fmul
jmp licz2


wyjatek:
fld1

koniec:
pop esi
pop edi
pop ebx
pop ebp
ret
_power ENDP
END