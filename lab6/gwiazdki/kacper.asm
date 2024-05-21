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
push cx
push dx


cmp cs:timer5, 90
jbe endd




mov ax, 0B800H ; adres pamiêci ekranu dla trybu 13H
mov es, ax
mov bx, 0

mov al, cs:bufKod[0]
mov es:[0], al
mov al, cs:bufKod[1]
mov es:[2], al
mov al, cs:bufKod[2]
mov es:[4], al
mov al, cs:bufKod[3]
mov es:[6], al
mov al, cs:bufKod[4]
mov es:[8], al

mov byte ptr es:[1], 00101111b
mov byte ptr es:[3], 00101111b
mov byte ptr es:[5], 00101111b
mov byte ptr es:[7], 00101111b
mov byte ptr es:[9], 00101111b




; odtworzenie rejestrów
 endd:
 inc cs:timer5
 pop dx
 pop cx
 pop es
 pop bx
 pop ax
; skok do oryginalnego podprogramu obs³ugi przerwania
; zegarowego
 jmp dword PTR cs:wektor8
; zmienne procedury

wektor8 dd ?

bufKod db 5 dup(0)



timer5 dw 0
mapa db '.1234567890....qwertyuiop....asdfghjkl.....zxcvbnm'

licznikTimer dw 0
wektor9 dd ?


linia ENDP

obsluga_klawiatury PROC
push ax
push bx
push dx
push es



cmp cs:timer5, 90
jb dalej

mov cs:zakoncz, 1




dalej:
cmp cs:iterator, 5
je koniec



in al, 60H
cmp al, 128
ja koniec

movzx bx,al
dec bx
mov dl,cs:mapa[bx]


mov bx,cs:iterator
mov cs:bufKod[bx],dl

inc cs:iterator



koniec:
pop es
pop dx
pop bx
pop ax

jmp dword PTR cs:wektor9


zakoncz dw 0
iterator dw 0
obsluga_klawiatury ENDP





; INT 10H, funkcja nr 0 ustawia tryb sterownika graficznego
zacznij:
mov ah, 5
mov al, 0 ; nr trybu
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

cmp cs:zakoncz, 1
jne czekaj
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
