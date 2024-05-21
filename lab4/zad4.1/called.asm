.686
.model flat

public _szukaj_max4

.data

.code


;extern int szukaj_max4(int a, int b, int c, int d);
_szukaj_max4 PROC
	push ebp
	mov ebp, esp
	push ebx



	mov ebx, 80000000h
	start:
	mov eax, [ebp + 8] ;a
	cmp eax, ebx
	jg swap

	mov eax, [ebp + 12] ;b
	cmp eax, ebx
	jg swap
	mov eax, [ebp + 16] ;c
	cmp eax, ebx
	jg swap
	mov eax, [ebp + 20] ;d
	cmp eax, ebx
	jg swap


	mov eax, ebx


	pop ebx


	pop ebp

	ret
	swap:
		mov ebx,eax
		jmp start



_szukaj_max4 ENDP
END
