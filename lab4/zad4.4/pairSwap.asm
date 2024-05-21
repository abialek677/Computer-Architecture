.686
.model flat

public _swap


.code

_swap PROC
push ebp
mov ebp, esp
push ebx

mov ebx, [ebp+8] ;adres
mov ecx, [ebp+12] ;liczba elementow


start:
mov eax, [ebx]
cmp eax, dword ptr [ebx+4]
jg swapp
inc ebx
loop start
jmp koniec

swapp:
mov edx, [ebx+4]
mov [ebx], edx
mov [ebx+4], eax
inc ebx
loop start

koniec:
pop ebx
pop ebp
ret






_swap ENDP
END