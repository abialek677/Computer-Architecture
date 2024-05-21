.686
.model flat
.XMM

public _main

extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC

.data

L1 dd 00111111100000000000000000000001b
L2 dd 01000000000000000000000000000001b
L3 dd 0

liczba db 01h,02h,03h,04h

.code

_main PROC

mov eax, 0


mov al, 10101010b
add al, 11111111b

mov ax, 0


;jae $-8

db 73h, 0F6h

push 0
call _ExitProcess@4
_main ENDP
END