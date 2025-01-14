.686
.model flat
extern __write : PROC
extern __read : PROC
extern _ExitProcess@4 : PROC
public _main

.data
znaki db 12 dup (?)

.code
wyswietl_EAX PROC
	PUSHA
	mov esi, 10 ; indeks w tablicy 'znaki'
	mov ebx, 10 ; dzielnik r�wny 10
	konwersja:
		mov edx, 0 ; zerowanie starszej cz�ci dzielnej
		div ebx ; dzielenie przez 10, reszta w EDX,
		; iloraz w EAX
		add dl, 30H ; zamiana reszty z dzielenia na kod
		; ASCII
		mov znaki [esi], dl; zapisanie cyfry w kodzie ASCII
		dec esi ; zmniejszenie indeksu
		cmp eax, 0 ; sprawdzenie czy iloraz = 0
	jne konwersja ; skok, gdy iloraz niezerowy
	; wype�nienie pozosta�ych bajt�w spacjami i wpisanie
	; znak�w nowego wiersza
	wypeln:
		or esi, esi
		jz wyswietl ; skok, gdy ESI = 0
		mov byte PTR znaki [esi], 20H ; kod spacji
		dec esi ; zmniejszenie indeksu
		jmp wypeln
	wyswietl:
		mov byte PTR znaki [0], 0AH ; kod nowego wiersza
		mov byte PTR znaki [11], 0AH ; kod nowego wiersza
		; wy�wietlenie cyfr na ekranie
		push dword PTR 12 ; liczba wy�wietlanych znak�w
		push dword PTR OFFSET znaki ; adres wy�w. obszaru
		push dword PTR 1; numer urz�dzenia (ekran ma numer 1)
		call __write ; wy�wietlenie liczby na ekranie
		add esp, 12 ; usuni�cie parametr�w ze stosu

	POPA
	RET
wyswietl_EAX ENDP

wyswietl_EAX2 PROC
	PUSHA
	mov esi, 10 ; indeks w tablicy 'znaki'
	mov ebx, 10 ; dzielnik r�wny 10
	konwersja:
		mov edx, 0 ; zerowanie starszej cz�ci dzielnej
		div ebx ; dzielenie przez 10, reszta w EDX,
		; iloraz w EAX
		add dl, 30H ; zamiana reszty z dzielenia na kod
		; ASCII
		mov znaki [esi], dl; zapisanie cyfry w kodzie ASCII
		dec esi ; zmniejszenie indeksu
		cmp eax, 0 ; sprawdzenie czy iloraz = 0
	jne konwersja ; skok, gdy iloraz niezerowy
	; wype�nienie pozosta�ych bajt�w spacjami i wpisanie
	; znak�w nowego wiersza
	wypeln:
		cmp esi, 0
		je wyswietl ; skok, gdy ESI = 0
		mov byte PTR znaki [esi], 20H ; kod spacji
		dec esi ; zmniejszenie indeksu
		jmp wypeln
	wyswietl:
		mov byte PTR znaki [0], 0AH ; kod nowego wiersza
		mov byte PTR znaki [11], 0AH ; kod nowego wiersza
		mov esi, 11
		jump:
			dec esi
			cmp byte PTR znaki[esi], 20H
		jnz jump
		mov byte PTR znaki[esi], '-'
		; wy�wietlenie cyfr na ekranie
		push dword PTR 12 ; liczba wy�wietlanych znak�w
		push dword PTR OFFSET znaki ; adres wy�w. obszaru
		push dword PTR 1; numer urz�dzenia (ekran ma numer 1)
		call __write ; wy�wietlenie liczby na ekranie
		add esp, 12 ; usuni�cie parametr�w ze stosu

	POPA
	RET
wyswietl_EAX2 ENDP

_main PROC


	mov ecx, 28
	mov eax, 1
	call wyswietl_EAX
	mov eax, 0
	call wyswietl_EAX
	mov edx, 1
	ptl1:
		inc edx
		mov eax, edx
		call wyswietl_EAX
		dec ecx
		jnz ptl2
		jmp endd
	ptl2:
		sub eax, 1
		call wyswietl_EAX2
		dec ecx
		jnz ptl1
		jmp endd
	endd:
	push 0
	call _ExitProcess@4
_main ENDP

END