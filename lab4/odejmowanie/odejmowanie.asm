.686
.model flat

public _odejmowanie

.code


;extern int odejmowanie(int** odjemna, int* odjemnik);
_odejmowanie PROC
push ebp
mov ebp, esp
push ebx

mov ebx, [ebp+8]
mov eax, [ebx]
mov eax, [eax] ; odjemna


mov ebx, [ebp+12]
mov edx, [ebx] ; odjemnik


sub eax, edx




pop ebx
pop ebp
ret
_odejmowanie ENDP
END