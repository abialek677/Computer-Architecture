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
mov bx, cs:adres_piksela ; adres bie��cy piksela
mov al, cs:kolor
mov es:[bx], al ; wpisanie kodu koloru do pami�ci ekranu
; przej�cie do nast�pnego wiersza na ekranie
add bx, cs:kierunek
; sprawdzenie czy ca�a linia wykre�lona
cmp bx, 320*200
jb dalej ; skok, gdy linia jeszcze nie wykre�lona
; kre�lenie linii zosta�o zako�czone - nast�pna linia b�dzie
; kre�lona w innym kolorze o 10 pikseli dalej
add word PTR cs:przyrost, 10
mov bx, 10
add bx, cs:przyrost
inc cs:kolor ; kolejny kod koloru
; zapisanie adresu bie��cego piksela
dalej:
mov cs:adres_piksela, bx
; odtworzenie rejestr�w
 pop es
 pop bx
 pop ax
; skok do oryginalnego podprogramu obs�ugi przerwania
; zegarowego
 jmp dword PTR cs:wektor8
; zmienne procedury
kolor db 1 ; bie��cy numer koloru
adres_piksela dw 10 ; bie��cy adres piksela
przyrost dw 0
wektor8 dd ?
wektor9 dd ?

kierunek dw 320


linia ENDP




obsluga_klawiatury PROC
push ax
push bx
push es

in al, 60H

cmp al, 75
je lewo
cmp al, 80
je dol
cmp al, 77
je right
cmp al, 72
je gora
jmp koniec


lewo:
mov cs:kierunek, -1
jmp koniec
dol:
mov cs:kierunek, 320
jmp koniec
right:
mov cs:kierunek, 1
jmp koniec
gora:
mov cs:kierunek, -320


koniec:
pop es
pop bx
pop ax

jmp dword PTR cs:wektor9


obsluga_klawiatury ENDP























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


;==========================================================================================
mov ax, 0
mov ds,ax ; zerowanie rejestru DS
; odczytanie zawarto�ci wektora nr 8 i zapisanie go
; w zmiennej 'wektor9' (wektor nr 8 zajmuje w pami�ci 4 bajty
; pocz�wszy od adresu fizycznego 8 * 4 = 32)
mov eax,ds:[36] ; adres fizyczny 0*16 + 32 = 32
mov cs:wektor9, eax

; wpisanie do wektora nr 8 adresu procedury 'obsluga_zegara'
mov ax, SEG obsluga_klawiatury ; cz�� segmentowa adresu
mov bx, OFFSET obsluga_klawiatury ; offset adresu
cli ; zablokowanie przerwa�
; zapisanie adresu procedury do wektora nr 8
mov ds:[36], bx ; OFFSET
mov ds:[38], ax ; cz. segmentowa
sti ;odblokowanie przerwa�

czekaj:
mov ah, 1 ; sprawdzenie czy jest jaki� znak
int 16h ; w buforze klawiatury
jz czekaj
mov ah, 0
int 16H
cmp al, 'x' ; por�wnanie z kodem litery 'x'
jne czekaj ; skok, gdy inny znak
; deinstalacja procedury obs�ugi przerwania zegarowego
; odtworzenie oryginalnej zawarto�ci wektora nr 8
mov ah, 0 ; funkcja nr 0 ustawia tryb sterownika
mov al, 3H ; nr trybu
int 10H
; odtworzenie oryginalnej zawarto�ci wektora nr 8
mov eax, cs:wektor8
mov es:[32], eax
mov eax, cs:wektor9
mov ds:[36], eax



; zako�czenie wykonywania programu
mov ax, 4C00H
int 21H
rozkazy ENDS
stosik SEGMENT stack
db 256 dup (?)
stosik ENDS
END zacznij