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


mov bx, cs:adres_piksela

mov al, cs:kolor

mov cx, 20
ptl1:
	mov es:[bx], al
	inc bx
loop ptl1

mov cx, 20
ptl2:
	mov es:[bx], al
	add bx, 320
loop ptl2


mov bx, cs:adres_piksela

mov cx, 20
ptl3:
	mov es:[bx], al
	add bx, 320
loop ptl3

mov cx, 21
ptl4:
	mov es:[bx], al
	inc bx
loop ptl4

mov al, cs:kolor2


cmp cs:timer, 5
jbe dalej
mov al, 0






dalej:
mov cx, 19
mov bx, cs:adres_piksela
inc bx
add bx, 320
mov cs:adres_piksela2, bx

ptlMain:
	mov bx, cs:adres_piksela2
	mov di, 19
	lessPtl:
	mov es:[bx], al
	add bx, 320
	dec di
	cmp di, 0
	jne lessPtl

	inc cs:adres_piksela2

loop ptlMain

inc cs:timer

cmp cs:timer, 10
jne koniec
mov cs:timer, 0

koniec:
; odtworzenie rejestrów
 pop es
 pop bx
 pop ax
; skok do oryginalnego podprogramu obs³ugi przerwania
; zegarowego
 jmp dword PTR cs:wektor8
; zmienne procedury
kolor db 1 ; bie¿¹cy numer koloru
kolor2 db 14
adres_piksela dw 2000 ; bie¿¹cy adres piksela
adres_piksela2 dw 2000 ; bie¿¹cy adres piksela
przyrost dw 0
wektor8 dd ?


timer dw 0



linia ENDP










obsluga_klawiatury PROC
push ax
push bx
push es


in al, 60h
cmp al, 19
jne koniec1

inc cs:licznikR

jmp koniecc
koniec1:
mov cs:licznikR, 0

koniecc:
cmp cs:licznikR, 36
jne koniecReal
mov cs:kolor2, 4

koniecReal:
pop es
pop bx
pop ax
; skok do oryginalnej procedury obs³ugi przerwania zegarowego
jmp dword PTR cs:wektor9
; dane programu ze wzglêdu na specyfikê obs³ugi przerwañ
; umieszczone s¹ w segmencie kodu
licznik dw 320 ; wyœwietlanie pocz¹wszy od 2. wiersza
wektor9 dd ?
licznikR dw 0
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

mov eax, es:[36]
mov cs:wektor9, eax
mov ax, SEG obsluga_klawiatury
mov bx, OFFSET obsluga_klawiatury

cli
mov es:[36], bx
mov es:[38], ax
sti





czekaj:
mov ah, 1 ; sprawdzenie czy jest jakiœ znak
int 16h ; w buforze klawiatury
jz czekaj
mov ah, 0
int 16H
cmp al, 'x'
jne czekaj
mov ah, 0 ; funkcja nr 0 ustawia tryb sterownika
mov al, 3H ; nr trybu
int 10H
; odtworzenie oryginalnej zawartoœci wektora nr 8
mov eax, cs:wektor8
mov es:[32], eax
mov eax, cs:wektor9
;mov es:[36], eax
; zakoñczenie wykonywania programu
mov ax, 4C00H
int 21H
rozkazy ENDS
stosik SEGMENT stack
db 256 dup (?)
stosik ENDS
END zacznij