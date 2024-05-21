public suma_siedmiu_liczb

.code

suma_siedmiu_liczb PROC
push rbp

mov rbp, rsp
add rbp, 48


mov rax, 0

add rax, rcx

add rax, rdx

add rax, r8

add rax, r9


mov rcx, 4
mov rdx, 0

ptl:
	add rax, [rbp + 8*rdx]
	inc rdx
loop ptl

pop rbp
ret
suma_siedmiu_liczb ENDP
END