.686
.model flat

public _plus1

.code

_plus1 PROC
push ebp
mov ebp, esp


mov ebx, [ebp + 8]

mov eax, [ebx]
inc eax
mov [ebx],eax


pop ebp
ret
_plus1 ENDP
END