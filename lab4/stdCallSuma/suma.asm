.686
.model flat



public suma


.code

suma PROC stdcall, arg1:sdword, arg2:sdword


mov eax, arg1
add eax, arg2











ret 8
suma ENDP
END