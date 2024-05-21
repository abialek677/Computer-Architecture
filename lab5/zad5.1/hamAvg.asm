.686
.model flat


public _srednia_harm

.data
jeden dd 1.0
zero dd 0.0



.code


;extern float srednia_harm(float* tablica, unsigned int n);
_srednia_harm PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

finit
mov ecx, [ebp+12]
mov ebx, [ebp + 8] ; adres tablicy floatow
mov edi, 0

fld zero ;to bedzie w st(2) i bedzie przechowywalo wynik ale for now jest w st(0)
ptl:
fld dword ptr [ebx+edi]
fld jeden
; 0 = 1.0	1 = a	2 = sum
fdiv st(0), st(1)
; 0 = 1/a	1 = a	2 = sum
fadd st(2), st(0)
fstp st(0)
fstp st(0)
add edi, 4
loop ptl

; st(0) = suma pod /

;mov ecx, [ebp + 12]
;push ecx
;fild dword ptr [esp]
;add esp, 4

fild dword ptr [ebp+12]

fdiv st(0),st(1)


pop esi
pop edi
pop ebx
pop ebp
ret
_srednia_harm ENDP
END