public szukaj64_max


.code

szukaj64_max PROC
push rbx


mov rbx, rcx ;adres tablicy - rbx
mov rcx, rdx ;liczba elementow - rcx
mov rdx, 0 ;miejsce w tablicy - rdx


mov rax, [rbx + 8*rdx]

dec rcx

ptl:
	inc rdx
	cmp rax, [rbx + 8*rdx]
	jg dalej


	mov rax, [rbx + 8*rdx]
dalej:
	loop ptl

pop rbx
ret
szukaj64_max ENDP
END