.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC ; (dwa znaki podkreœlenia)
extern __read : PROC ; (dwa znaki podkreœlenia)
public _main

.data
tekst_pocz db 10, 'Prosz', 0A9H , ' napisa', 86H,' jaki',98H,' tekst '
db 'i nacisn',0A5H,86H,' Enter', 10
koniec_t db ?
magazyn db 80 dup (?)
magazynHelp db 80 dup (?)
nowa_linia db 10
liczba_znakow dd ?

.code
_main PROC
; wyœwietlenie tekstu informacyjnego
; liczba znaków tekstu
 mov ecx,(OFFSET koniec_t) - (OFFSET tekst_pocz)
 push ecx
 push OFFSET tekst_pocz ; adres tekstu
 push 1 ; nr urz¹dzenia (tu: ekran - nr 1)
 call __write ; wyœwietlenie tekstu pocz¹tkowego
 add esp, 12 ; usuniecie parametrów ze stosu
; czytanie wiersza z klawiatury
 push 80 ; maksymalna liczba znaków
 push OFFSET magazyn
 push 0 ; nr urz¹dzenia (tu: klawiatura - nr 0)
 call __read ; czytanie znaków z klawiatury
 add esp, 12 ; usuniecie parametrów ze stosu
; kody ASCII napisanego tekstu zosta³y wprowadzone
; do obszaru 'magazyn'
; funkcja read wpisuje do rejestru EAX liczbê
; wprowadzonych znaków
 mov liczba_znakow, eax
; rejestr ECX pe³ni rolê licznika obiegów pêtli
 mov ecx, eax
 mov ebx, 0 ; indeks pocz¹tkowy
 mov eax, 0
ptl: mov dl, magazyn[ebx] ; pobranie kolejnego znaku

;/
cmp dl, 2FH
je jumpSlash
;¹
cmp dl, 0A5H
je jumpA
;æ
cmp dl, 86H
je jumpC
;ê
cmp dl, 0A9H
je jumpE
;³
cmp dl, 88H
je jumpL
;ñ
cmp dl, 0E4H
je jumpN
;ó
cmp dl, 0A2H
je jumpO
;œ
cmp dl, 98H
je jumpS
;Ÿ
cmp dl, 0ABH
je jumpX
;¿
cmp dl, 0BEH
je jumpZ


 cmp dl, 'a'
 jb dalej ; skok, gdy znak nie wymaga zamiany
 cmp dl, 'z'
 ja dalej ; skok, gdy znak nie wymaga zamiany
 sub dl, 20H ; zamiana na wielkie litery
; odes³anie znaku do pamiêci
jmp dalej

jumpSlash:
mov dl, 20H
mov magazynHelp[eax], dl
inc eax
mov magazynHelp[eax], dl
inc eax
mov magazynHelp[eax], dl
inc eax
inc ebx
dec ecx
add liczba_znakow, 2
jnz ptl


jumpA:
mov dl, 0A4H
jmp dalej

jumpC:
mov dl, 8FH
jmp dalej

jumpE:
mov dl, 0A8H
jmp dalej

jumpL:
mov dl, 9DH
jmp dalej

jumpN:
mov dl, 0E3H
jmp dalej

jumpO:
mov dl, 0E0H
jmp dalej

jumpS:
mov dl, 97H
jmp dalej

jumpX:
mov dl, 8DH
jmp dalej

jumpZ:
mov dl, 0BDH
jmp dalej


dalej: 
 mov magazynHelp[eax], dl
inc ebx ; inkrementacja indeksu
inc eax
dec ecx
jnz ptl; sterowanie pêtl¹
; wyœwietlenie przekszta³conego tekstu
 push liczba_znakow
 push OFFSET magazynHelp
 push 1
 call __write ; wyœwietlenie przekszta³conego tekstu
 add esp, 12 ; usuniecie parametrów ze stosu
 push 0
 call _ExitProcess@4 ; zakoñczenie programu
_main ENDP
END