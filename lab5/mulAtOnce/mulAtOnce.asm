.686
.model flat
.XMM

public _mul

.code
;extern __m128 mul(__m128 one, __m128 two);
_mul PROC
push ebp
mov ebp, esp
push ebx
push esi
push edi





PMULLD xmm0, xmm1



pop edi
pop esi
pop ebx
pop ebp
ret
_mul ENDP
END