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
mov ax, 0A000H ; adres pami�ci ekranu dla trybu 13H
mov es, ax

mov bx, cs:adres_piksela
mov al, cs:kolor
mov es:[bx], al

add bx, 320
sub bx, cs:currentX
sub bx, cs:currentX
mov es:[bx], al

cmp cs:D, 0
jle dalej
add cs:currentY, 320
sub cs:D, 640

dalej:
add cs:D, 400



mov bx, cs:currentY
add bx, cs:currentX
mov cs:adres_piksela, bx
inc cs:currentX




; odtworzenie rejestr�w
 pop es
 pop bx
 pop ax
; skok do oryginalnego podprogramu obs�ugi przerwania
; zegarowego
 jmp dword PTR cs:wektor8
; zmienne procedury
kolor db 1 ; bie��cy numer koloru
adres_piksela dw 0 ; bie��cy adres piksela
D dw 80

currentX dw 0
currentY dw 0

wektor8 dd ?
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