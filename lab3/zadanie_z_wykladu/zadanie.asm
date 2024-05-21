.686
.model flat

public _main
extern _ExitProcess@4 : PROC

.data

.code


funk PROC



mov eax, [esp]
mov eax, [eax]

add [esp],dword ptr 8




ret
funk ENDP



_main PROC


call funk
dq 5


push 0
call _ExitProcess@4

_main ENDP
END
