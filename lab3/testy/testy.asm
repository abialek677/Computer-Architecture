.686
.model flat

extern _ExitProcess@4 : PROC
public _main

.data
wskaznik dd 12
v2 dw ?

.code

dodaj PROC
mov esi, [esp]
mov eax, [esi]
add eax, [esi+4]
add byte ptr [esp], 8
ret
dodaj ENDP

_main PROC
mov v2, 11111h


call dodaj
dd 5
dd 7
push 0
koniec:
	push 0
call _ExitProcess@4


_main ENDP
END