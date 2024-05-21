.686
.model flat

public _progowanie_sredniej_kroczacej

.code
;extern float progowanie_sredniej_kroczacej(float* tab, unsigned int k, unsigned int m);
_progowanie_sredniej_kroczacej PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi

mov ebx, [ebp+8] ;adres tablicy
mov ecx, [ebp+12] ;k
mov edx, [ebp+16] ;m (rozmiar sliding window)
sub ecx, edx
inc ecx	;iteracje sliding window
finit
sub esp, 4
mov edi, esp ; adres zarezerwowanego obszaru


fldz
fst dword ptr [edi]
fstp st(0)

mainLoop:

	mov esi, 0
	mov eax, edx

	fldz
	load_sum:
	fld dword ptr	[ebx+esi] 
	fadd
	add esi, 4
	dec eax
	cmp eax, 0
	jne load_sum



	push edx
	fild dword ptr [esp]
	add esp, 4
	fdiv
	fst st(1)
	fld dword ptr [edi]
	fsub
	fabs
	;w st(0) roznica do porownania

	mov eax, 3
	push eax
	fild dword ptr [esp]
	add esp, 4
	mov eax, 5
	push eax
	fild dword ptr [esp]
	add esp, 4
	fdiv
	;st0 = 0.6	1 = roznica
	fcomi st(0), st(1)
	ja breakCase
	fstp st(0)
	fstp st(0)
	fstp dword ptr [edi]
	add ebx, 4
dec ecx
cmp ecx, 0
jne mainLoop
jmp koniec

breakCase:
fstp st(0)
fstp st(0)
fstp dword ptr [edi]



koniec:
fld dword ptr [edi]
add esp, 4

pop esi
pop edi
pop ebx
pop ebp
ret
_progowanie_sredniej_kroczacej ENDP
END