; Program gwiazdki.asm
; Wy�wietlanie znak�w * w takt przerwa� zegarowych
; Uruchomienie w trybie rzeczywistym procesora x86
; lub na maszynie wirtualnej
; zako�czenie programu po naci�ni�ciu klawisza 'x'
; asemblacja (MASM 4.0): masm gwiazdki.asm,,,;
; konsolidacja (LINK 3.60): link gwiazdki.obj;
.386
rozkazy SEGMENT use16
ASSUME CS:rozkazy






;============================================================
; procedura obs�ugi przerwania zegarowego
obsluga_zegara PROC
; przechowanie u�ywanych rejestr�w
push ax
push bx
push es

cmp cs:bool, 1
jne koniec

cmp cs:timer, 18
jne koniec
mov cs:timer, 0
; wpisanie adresu pami�ci ekranu do rejestru ES - pami��
; ekranu dla trybu tekstowego zaczyna si� od adresu B8000H,
; jednak do rejestru ES wpisujemy warto�� B800H,
; bo w trakcie obliczenia adresu procesor ka�dorazowo mno�y
; zawarto�� rejestru ES przez 16
mov ax, 0B800h ;adres pami�ci ekranu
mov es, ax
; zmienna 'licznik' zawiera adres bie��cy w pami�ci ekranu
mov bx, cs:licznik
; przes�anie do pami�ci ekranu kodu ASCII wy�wietlanego znaku
; i kodu koloru: bia�y na czarnym tle (do nast�pnego bajtu)
mov byte PTR es:[bx], '*' ; kod ASCII
mov byte PTR es:[bx+1], 00000111B ; kolor
; zwi�kszenie o 2 adresu bie��cego w pami�ci ekranu
add bx,2
; sprawdzenie czy adres bie��cy osi�gn�� koniec pami�ci ekranu
cmp bx,4000
jb wysw_dalej ; skok gdy nie koniec ekranu
; wyzerowanie adresu bie��cego, gdy ca�y ekran zapisany
mov bx, 0
;zapisanie adresu bie��cego do zmiennej 'licznik'
wysw_dalej:
mov cs:licznik,bx
inc cs:licznik26

cmp cs:licznik26, 26
jne koniec

mov cs:bool, 0
; odtworzenie rejestr�w



koniec:
inc cs:timer
pop es
pop bx
pop ax
; skok do oryginalnej procedury obs�ugi przerwania zegarowego
jmp dword PTR cs:wektor8
; dane programu ze wzgl�du na specyfik� obs�ugi przerwa�
; umieszczone s� w segmencie kodu










licznik dw 0 ; wy�wietlanie pocz�wszy od 2. wiersza
wektor8 dd ?

bool dw 1
licznik26 dw 0

timer dw 0
obsluga_zegara ENDP







;============================================================
; program g��wny - instalacja i deinstalacja procedury
; obs�ugi przerwa�
; ustalenie strony nr 0 dla trybu tekstowego
zacznij:
mov al, 0
mov ah, 5
int 10h
mov ax, 0
mov ds,ax ; zerowanie rejestru DS
; odczytanie zawarto�ci wektora nr 8 i zapisanie go
; w zmiennej 'wektor8' (wektor nr 8 zajmuje w pami�ci 4 bajty
; pocz�wszy od adresu fizycznego 8 * 4 = 32)
mov eax,ds:[32] ; adres fizyczny 0*16 + 32 = 32
mov cs:wektor8, eax

; wpisanie do wektora nr 8 adresu procedury 'obsluga_zegara'
mov ax, SEG obsluga_zegara ; cz�� segmentowa adresu
mov bx, OFFSET obsluga_zegara ; offset adresu
cli ; zablokowanie przerwa�
; zapisanie adresu procedury do wektora nr 8
mov ds:[32], bx ; OFFSET
mov ds:[34], ax ; cz. segmentowa
sti ;odblokowanie przerwa�
; oczekiwanie na naci�ni�cie klawisza 'x'
aktywne_oczekiwanie:
cmp cs:bool, 0
je zakoncz
mov ah,1
int 16H
; funkcja INT 16H (AH=1) BIOSu ustawia ZF=1 je�li
; naci�ni�to jaki� klawisz
jz aktywne_oczekiwanie
; odczytanie kodu ASCII naci�ni�tego klawisza (INT 16H, AH=0)
; do rejestru AL
mov ah, 0
int 16H

mov cs:licznik, 0
mov cs:licznik26, 0


cmp al, 0DH ; por�wnanie z kodem litery 'x'
jne aktywne_oczekiwanie ; skok, gdy inny znak
; deinstalacja procedury obs�ugi przerwania zegarowego
; odtworzenie oryginalnej zawarto�ci wektora nr 8
mov eax, cs:wektor8
cli
mov ds:[32], eax ; przes�anie warto�ci oryginalnej
; do wektora 8 w tablicy wektor�w
; przerwa�
sti
; zako�czenie programu
zakoncz:
mov al, 0
mov ah, 4CH
int 21H
rozkazy ENDS
nasz_stos SEGMENT stack
db 128 dup (?)
nasz_stos ENDS
END zacznij
