.386
rozkazy SEGMENT use16
ASSUME cs:rozkazy


obsluga_zegara PROC
 push ax
 push bx
 push es

 cmp cs:timer5, 90
 jb koniec




 mov ax, 0B800H
 mov es, ax

 mov bl, cs:bufor[0]
 mov es:[0], bl
 mov byte ptr es:[1], 00101111b


 mov bl, cs:bufor[1]
 mov es:[2], bl
 mov byte ptr es:[3], 00101111b


 mov bl, cs:bufor[2]
 mov es:[4], bl
 mov byte ptr es:[5], 00101111b


 mov bl, cs:bufor[3]
 mov es:[6], bl
 mov byte ptr es:[7], 00101111b


 mov bl, cs:bufor[4]
 mov es:[8], bl
 mov byte ptr es:[9], 00101111b



 mov cs:timer5, 90

 koniec:
 inc cs:timer5
 pop es
 pop bx
 pop ax

 jmp dword PTR cs:wektor8


 wektor8 dd ?

 timer5 dw 0

 bufor db 5 dup(0)


obsluga_zegara ENDP

obsluga_klawiatury PROC
 push ax
 push bx
 push es



 cmp cs:timer5, 90
 jb dalej

 mov cs:zakoncz, 1




 dalej:
 cmp cs:index, 5
 je endd

 in al, 60H
 cmp al, 128
 ja endd

 movzx bx, al
 dec bx
 mov al, cs:mapa[bx]

 mov bx, cs:index
 mov cs:bufor[bx], al

 inc cs:index


 endd:
 pop es
 pop bx
 pop ax

 jmp dword PTR cs:wektor9


 wektor9 dd ?

 index dw 0

 mapa db '.1234567890....qwertyuiop....asdfghjkl.....zxcvbnm'

 zakoncz db 0

obsluga_klawiatury ENDP





zacznij:
mov ah, 5
mov al, 0 
int 10H


mov bx, 0
mov es, bx 
mov eax, es:[32] 
mov cs:wektor8, eax


mov ax, SEG obsluga_zegara
mov bx, OFFSET obsluga_zegara


cli
mov es:[32], bx
mov es:[32+2], ax
sti 


cli
mov ax, 4C00H
int 21H
sti

mov ax, 0
mov ds,ax 
mov eax,ds:[36] 
mov cs:wektor9, eax


mov ax, SEG obsluga_klawiatury 
mov bx, OFFSET obsluga_klawiatury




czekaj:
cmp cs:zakoncz, 1
jne czekaj



mov eax, cs:wektor8
mov es:[32], eax
mov eax, cs:wektor9
mov ds:[36], eax


; zakoñczenie wykonywania programu
mov ax, 4C00H
int 21H
rozkazy ENDS
stosik SEGMENT stack
db 256 dup (?)
stosik ENDS
END zacznij
