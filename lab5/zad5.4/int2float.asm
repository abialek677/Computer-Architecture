.686
.XMM
.model flat

public _int2float


.code
;extern void int2float(int* calkowite, float* zmienno_przec);
_int2float PROC
push ebp
mov ebp, esp
push ebx
push esi
push edi

mov ebx, [ebp + 8] ; adres calkowitych
mov esi, [ebp + 12] ; adres wyniku

cvtpi2ps xmm0, qword ptr [ebx]

movups [esi], xmm0



pop ebp
pop ebx
pop esi
pop edi
ret
_int2float ENDP
END