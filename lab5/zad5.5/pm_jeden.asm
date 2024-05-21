.686
.XMM
.model flat


public _pm_jeden



.data

tab dd 4 dup (1.0)

.code

;extern void pm_jeden(float* tabl)
_pm_jeden PROC
push ebp
mov ebp, esp
push ebx
push esi
push edi

mov ebx, [ebp+8] ; adres tablicy floatow


movups xmm0, [ebx]

movups xmm1, tab

addsubps xmm0, xmm1

movups [ebx],xmm0





pop edi
pop esi
pop ebx
pop ebp
ret
_pm_jeden ENDP
END