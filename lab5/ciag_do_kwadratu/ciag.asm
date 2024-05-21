.686
.model flat

public _ciag

.code

_ciag PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

finit
fldz
mov ecx, [ebp+8]
mov esi, 1
ptl:




loop ptl


pop esi
pop edi
pop ebx
pop ebp
ret
_ciag ENDP
END