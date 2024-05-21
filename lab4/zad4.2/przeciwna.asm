.686
.model flat

public _negative_num


.code

_negative_num PROC

push ebp
mov ebp, esp
push ebx

mov ebx, [ebp + 8]

mov eax, [ebx]

neg eax

mov [ebx], eax






pop ebx
pop ebp
ret
_negative_num ENDP
END