; Program linie.asm
; Wy�wietlanie znak�w * w takt przerwa� zegarowych
; Uruchomienie w trybie rzeczywistym procesora x86
; lub na maszynie wirtualnej
; zako�czenie programu po naci�ni�ciu dowolnego klawisza
; asemblacja (MASM 4.0): masm gwiazdki.asm,,,;
; konsolidacja (LINK 3.60): link gwiazdki.obj;
.386
rozkazy SEGMENT use16
ASSUME cs:rozkazy



linia PROC
; przechowanie rejestr�w
push ax
push bx
push es
push dx
push cx
cmp cs:wykonuj, 0
je dalej


mov ax, 0A000H ; adres pami�ci ekranu dla trybu 13H
mov es, ax

mov ax, cs:yCurrent
mov cx, 320
mul cx
mov bx, ax
mov cx, ax
add bx, cs:xCurrent
mov al, cs:kolor
mov es:[bx], al


mov dx, 320
sub dx, cs:xCurrent
add cx, dx

xchg cx, bx
mov es:[bx], al
xchg cx, bx

mov cx, cs:D
cmp cx, 0
jle dontAdd
inc cs:yCurrent
sub cx, 640
dontAdd:
inc cs:xCurrent
add cx, 400
mov cs:D, cx



cmp bx, 320*200
jb dalej


mov cs:wykonuj, 0





 dalej:
 mov cs:adres_piksela, bx
 ; odtworzenie rejestr�w
 pop cx
 pop dx
 pop es
 pop bx
 pop ax





; skok do oryginalnego podprogramu obs�ugi przerwania
; zegarowego

 jmp dword PTR cs:wektor8
; zmienne procedury
kolor db 1 ; bie��cy numer koloru
adres_piksela dw 0 ; bie��cy adres piksela
przyrost dw 0
wektor8 dd ?
xCurrent dw 0
yCurrent dw 0
D dw 80
wykonuj dw 1

linia ENDP






; INT 10H, funkcja nr 0 ustawia tryb sterownika graficznego
zacznij:
mov ah, 0
mov al, 13H ; nr trybu
int 10H
mov bx, 0
mov es, bx ; zerowanie rejestru ES
mov eax, es:[32] ; odczytanie wektora nr 8
mov cs:wektor8, eax; zapami�tanie wektora nr 8
; adres procedury 'linia' w postaci segment:offset
mov ax, SEG linia
mov bx, OFFSET linia
cli ; zablokowanie przerwa�
; zapisanie adresu procedury 'linia' do wektora nr 8
mov es:[32], bx
mov es:[32+2], ax
sti ; odblokowanie przerwa�
czekaj:
mov ah, 1 ; sprawdzenie czy jest jaki� znak
int 16h ; w buforze klawiatury
jz czekaj
mov ah, 0 ; funkcja nr 0 ustawia tryb sterownika
mov al, 3H ; nr trybu
int 10H
; odtworzenie oryginalnej zawarto�ci wektora nr 8
mov eax, cs:wektor8
mov es:[32], eax
; zako�czenie wykonywania programu
mov ax, 4C00H
int 21H
rozkazy ENDS
stosik SEGMENT stack
db 256 dup (?)
stosik ENDS
END zacznij