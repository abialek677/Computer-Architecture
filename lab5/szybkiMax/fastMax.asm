.686
.model flat
.XMM

public _fastMax


.code
;extern __m128 fastMax(short int tab1[], short int tab2[]);
_fastMax PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi


mov esi, [ebp+8]
mov edi, [ebp+12]

movups xmm0, [esi]
movups xmm1, [edi]

PMAXSW xmm0,xmm1




pop esi
pop edi
pop ebx
pop ebp
db 0c3h
_fastMax ENDP
END