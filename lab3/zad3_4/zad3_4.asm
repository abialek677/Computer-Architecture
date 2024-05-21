.686
.model flat

extern __write : PROC
extern __read : PROC
extern _ExitProcess@4 : PROC
public _main

.data
obszar db 12 dup (?)
dziesiec dd 10 ; mno�nik
dekoder db '0123456789ABCDEF'

.code
	wyswietl_EAX_hex PROC
	; wy�wietlanie zawarto�ci rejestru EAX
	; w postaci liczby szesnastkowej
	pusha ; przechowanie rejestr�w

	; rezerwacja 12 bajt�w na stosie (poprzez zmniejszenie
	; rejestru ESP) przeznaczonych na tymczasowe przechowanie
	; cyfr szesnastkowych wy�wietlanej liczby
	sub esp, 12
	mov edi, esp ; adres zarezerwowanego obszaru
	; pami�ci
	; przygotowanie konwersji
	mov ecx, 8 ; liczba obieg�w p�tli konwersji
	mov esi, 1 ; indeks pocz�tkowy u�ywany przy
	; zapisie cyfr
	; p�tla konwersji
	ptl3hex:
		; przesuni�cie cykliczne (obr�t) rejestru EAX o 4 bity w lewo
		; w szczeg�lno�ci, w pierwszym obiegu p�tli bity nr 31 - 28
		; rejestru EAX zostan� przesuni�te na pozycje 3 - 0
		rol eax, 4
		; wyodr�bnienie 4 najm�odszych bit�w i odczytanie z tablicy
		; 'dekoder' odpowiadaj�cej im cyfry w zapisie szesnastkowym
		mov ebx, eax ; kopiowanie EAX do EBX
		and ebx, 0000000FH ; zerowanie bit�w 31 - 4 rej.EBX
		mov dl, dekoder[ebx] ; pobranie cyfry z tablicy
		; przes�anie cyfry do obszaru roboczego
		mov [edi][esi], dl			;to samo co [edi + esi]
		inc esi ;inkrementacja modyfikatora
	loop ptl3hex ; sterowanie p�tl�

	; wpisanie znaku nowego wiersza przed i po cyfrach
	mov byte PTR [edi][0], 10
	mov byte PTR [edi][9], 10

	; wy�wietlenie przygotowanych cyfr
	push 10 ; 8 cyfr + 2 znaki nowego wiersza
	push edi ; adres obszaru roboczego
	push 1 ; nr urz�dzenia (tu: ekran)
	call __write ; wy�wietlenie
	; usuni�cie ze stosu 24 bajt�w, w tym 12 bajt�w zapisanych
	; przez 3 rozkazy push przed rozkazem call
	; i 12 bajt�w zarezerwowanych na pocz�tku podprogramu
	add esp, 24

	popa ; odtworzenie rejestr�w
	ret ; powr�t z podprogramu
wyswietl_EAX_hex ENDP


wczytaj_do_EAX PROC

	push ebx
	push edx
	push ecx
	; max ilo�� znak�w wczytywanej liczby
	push dword PTR 12
	push dword PTR OFFSET obszar ; adres obszaru pami�ci
	push dword PTR 0; numer urz�dzenia (0 dla klawiatury)
	call __read ; odczytywanie znak�w z klawiatury
	; (dwa znaki podkre�lenia przed read)
	add esp, 12 ; usuni�cie parametr�w ze stosu
	; bie��ca warto�� przekszta�canej liczby przechowywana jest
	; w rejestrze EAX; przyjmujemy 0 jako warto�� pocz�tkow�
	mov eax, 0
	mov ebx, OFFSET obszar ; adres obszaru ze znakami
	pobieraj_znaki:
		mov cl, [ebx] ; pobranie kolejnej cyfry w kodzie
		; ASCII
		inc ebx ; zwi�kszenie indeksu
		cmp cl,10 ; sprawdzenie czy naci�ni�to Enter
	je byl_enter ; skok, gdy naci�ni�to Enter
		sub cl, 30H ; zamiana kodu ASCII na warto�� cyfry
		movzx ecx, cl ; przechowanie warto�ci cyfry w
		; rejestrze ECX
		; mno�enie wcze�niej obliczonej warto�ci razy 10
		mul dword PTR dziesiec
		add eax, ecx ; dodanie ostatnio odczytanej cyfry
	jmp pobieraj_znaki ; skok na pocz�tek p�tli
	byl_enter:

	pop ecx
	pop edx
	pop ebx

	RET
wczytaj_do_EAX ENDP


_main PROC
	

	call wczytaj_do_EAX

	call wyswietl_EAX_hex

	push 0
	call _ExitProcess@4

_main ENDP
END