.686
.model flat
extern _ExitProcess@4 : PROC
public _main

.code
_main PROC
	mov eax, 0
	mov ebx, 3
	mov ecx, 6
ptl:
	add eax, ebx
	add ebx, 2
	sub ecx, 1
jnz ptl


call _ExitProcess@4
_main ENDP
END