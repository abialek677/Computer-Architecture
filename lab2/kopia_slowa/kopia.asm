.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC ; (dwa znaki podkre�lenia)
extern __read : PROC ; (dwa znaki podkre�lenia)
public _main

.data
tekst_pocz db 10, 'Prosz', 0A9H , ' napisa', 86H,' jaki',98H,' tekst '
db 'i nacisn',0A5H,86H,' Enter', 10
koniec_t db ?
magazyn db 80 dup (?)
magazynFinal db 160 dup (?)
liczba_znakow dd ?
liczba_znakow_fin dd 0
cpy_word dd ?

.code
_main PROC
; wy�wietlenie tekstu informacyjnego
; liczba znak�w tekstu
 mov ecx,(OFFSET koniec_t) - (OFFSET tekst_pocz)
 push ecx
 push OFFSET tekst_pocz ; adres tekstu
 push 1 ; nr urz�dzenia (tu: ekran - nr 1)
 call __write ; wy�wietlenie tekstu pocz�tkowego
 add esp, 12 ; usuniecie parametr�w ze stosu
; czytanie wiersza z klawiatury
 push 80 ; maksymalna liczba znak�w
 push OFFSET magazyn
 push 0 ; nr urz�dzenia (tu: klawiatura - nr 0)
 call __read ; czytanie znak�w z klawiatury
 add esp, 12 ; usuniecie parametr�w ze stosu
; kody ASCII napisanego tekstu zosta�y wprowadzone
; do obszaru 'magazyn'
; funkcja read wpisuje do rejestru EAX liczb�
; wprowadzonych znak�w
mov cpy_word, OFFSET magazyn
 mov liczba_znakow, eax
; rejestr ECX pe�ni rol� licznika obieg�w p�tli
 mov ecx, eax
 mov ebx, 0 ; indeks pocz�tkowy
 mov eax, 0
ptl: 
mov dl, magazyn[ebx] ; pobranie kolejnego znaku

cmp dl, 5CH
je check_cpy
cmp dl, 20H
je check_word
mov magazynFinal[eax], dl
jmp dalej


check_cpy:
mov dl, magazyn[ebx+1]
cmp dl, 'd'
je paste_cpy
mov dl, magazyn[ebx]
mov magazynFinal[eax], dl
jmp dalej

paste_cpy:
mov esi, cpy_word
paste_word:
mov dl, [esi]
cmp dl, ' '
je next
mov magazynFinal[eax],dl
inc esi
inc eax
jmp paste_word
next:
add ebx, 2
sub ecx, 2
jz done
jmp ptl



check_word:
mov dl, magazyn[ebx+1]
cmp dl, 5CH
je not_word
mov dl, magazyn[ebx]
mov magazynFinal[eax], dl
mov cpy_word, OFFSET magazyn
add cpy_word, ebx
inc cpy_word
jmp dalej


not_word:
mov dl, magazyn[ebx]
mov magazynFinal[eax], dl
jmp dalej




dalej: 
 inc eax
 inc ebx
 dec ecx
jnz ptl 
 done:
 push eax
 push OFFSET magazynFinal
 push 1
 call __write ; wy�wietlenie przekszta�conego tekstu
 add esp, 12 ; usuniecie parametr�w ze stosu
 push 0
 call _ExitProcess@4 ; zako�czenie programu
_main ENDP
END