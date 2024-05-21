.686
.model flat


public _fibonaci



.code

_fibonaci PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

mov edi, [ebp + 8] ; indeks

cmp edi, 2
jbe stop

dec edi
push edi
call _fibonaci
pop edi
mov ebx, eax
dec edi
push edi
call _fibonaci
pop edi

add eax, ebx
jmp koniec
stop:
mov eax, 1
koniec:

pop esi
pop edi
pop ebx
pop ebp
ret 
_fibonaci ENDP
END