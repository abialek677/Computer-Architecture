; Program linie.asm
; Wyœwietlanie znaków * w takt przerwañ zegarowych
; Uruchomienie w trybie rzeczywistym procesora x86
; lub na maszynie wirtualnej
; zakoñczenie programu po naciœniêciu dowolnego klawisza
; asemblacja (MASM 4.0): masm gwiazdki.asm,,,;
; konsolidacja (LINK 3.60): link gwiazdki.obj;
.386
rozkazy SEGMENT use16
ASSUME cs:rozkazy





linia PROC
; przechowanie rejestrów
push ax
push bx
push es
mov ax, 0A000H ; adres pamiêci ekranu dla trybu 13H
mov es, ax
mov bx, cs:adres_piksela ; adres bie¿¹cy piksela
mov al, cs:kolor
mov es:[bx], al ; wpisanie kodu koloru do pamiêci ekranu
; przejœcie do nastêpnego wiersza na ekranie
add bx, cs:kierunek
; sprawdzenie czy ca³a linia wykreœlona
cmp bx, 320*200
jb dalej ; skok, gdy linia jeszcze nie wykreœlona
; kreœlenie linii zosta³o zakoñczone - nastêpna linia bêdzie
; kreœlona w innym kolorze o 10 pikseli dalej
add word PTR cs:przyrost, 10
mov bx, 10
add bx, cs:przyrost
inc cs:kolor ; kolejny kod koloru
; zapisanie adresu bie¿¹cego piksela
dalej:
mov cs:adres_piksela, bx
; odtworzenie rejestrów
 pop es
 pop bx
 pop ax
; skok do oryginalnego podprogramu obs³ugi przerwania
; zegarowego
 jmp dword PTR cs:wektor8
; zmienne procedury
kolor db 1 ; bie¿¹cy numer koloru
adres_piksela dw 10 ; bie¿¹cy adres piksela
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
mov cs:wektor8, eax; zapamiêtanie wektora nr 8
; adres procedury 'linia' w postaci segment:offset
mov ax, SEG linia
mov bx, OFFSET linia
cli ; zablokowanie przerwañ
; zapisanie adresu procedury 'linia' do wektora nr 8
mov es:[32], bx
mov es:[32+2], ax
sti ; odblokowanie przerwañ


;==========================================================================================
mov ax, 0
mov ds,ax ; zerowanie rejestru DS
; odczytanie zawartoœci wektora nr 8 i zapisanie go
; w zmiennej 'wektor9' (wektor nr 8 zajmuje w pamiêci 4 bajty
; pocz¹wszy od adresu fizycznego 8 * 4 = 32)
mov eax,ds:[36] ; adres fizyczny 0*16 + 32 = 32
mov cs:wektor9, eax

; wpisanie do wektora nr 8 adresu procedury 'obsluga_zegara'
mov ax, SEG obsluga_klawiatury ; czêœæ segmentowa adresu
mov bx, OFFSET obsluga_klawiatury ; offset adresu
cli ; zablokowanie przerwañ
; zapisanie adresu procedury do wektora nr 8
mov ds:[36], bx ; OFFSET
mov ds:[38], ax ; cz. segmentowa
sti ;odblokowanie przerwañ

czekaj:
mov ah, 1 ; sprawdzenie czy jest jakiœ znak
int 16h ; w buforze klawiatury
jz czekaj
mov ah, 0
int 16H
cmp al, 'x' ; porównanie z kodem litery 'x'
jne czekaj ; skok, gdy inny znak
; deinstalacja procedury obs³ugi przerwania zegarowego
; odtworzenie oryginalnej zawartoœci wektora nr 8
mov ah, 0 ; funkcja nr 0 ustawia tryb sterownika
mov al, 3H ; nr trybu
int 10H
; odtworzenie oryginalnej zawartoœci wektora nr 8
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