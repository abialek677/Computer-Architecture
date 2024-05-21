.386
rozkazy SEGMENT use16
ASSUME cs:rozkazy


obsluga_zegara PROC
 push ax
 push bx
 push es


 mov ax, 0B800H
 mov es, ax





 pop es
 pop bx
 pop ax

 jmp dword PTR cs:wektor8


 wektor8 dd ?

obsluga_zegara ENDP

obsluga_klawiatury PROC
 push ax
 push bx
 push es

 in al, 60H
 

 pop es
 pop bx
 pop ax

 jmp dword PTR cs:wektor9


 wektor9 dd ?

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


mov ax, 0
mov ds,ax 
mov eax,ds:[36] 
mov cs:wektor9, eax


mov ax, SEG obsluga_klawiatury 
mov bx, OFFSET obsluga_klawiatury


cli 
mov ds:[36], bx 
mov ds:[38], ax 
sti 


czekaj:
mov ah, 1
int 16h
jz czekaj
mov ah, 0
int 16h
cmp al, 'x'
jne czekaj


mov ah, 0 
mov al, 3H 
int 10H

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
