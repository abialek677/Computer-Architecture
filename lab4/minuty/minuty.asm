.686
.model flat

public _minutes
extern _GetSystemTime@4 : PROC


.code

_minutes PROC
push ebp
mov ebp, esp
push edi

sub esp, 12
mov edi, esp

push edi
call _GetSystemTime@4

mov ax, [edi + 10]
movzx eax, ax


add esp, 12

pop edi
pop ebp
ret
_minutes ENDP
END