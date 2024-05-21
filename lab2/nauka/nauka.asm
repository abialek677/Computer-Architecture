.686
.model flat

extern _ExitProcess@4 : PROC

public _main

.data

.code


_main PROC



mov eax, 0
sub eax, 18

mov ebx,4
mov ebx,4
mov ebx,4
mov ebx,4
mov ebx,4
add eax, 25




push 0
call _ExitProcess@4

_main ENDP
END