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
		mov edx, 0 
		div ebx
		add dl, 30H 

		mov znaki [esi], dl
		dec esi
		cmp eax, 0
	jne konwersja
	wypeln:
		or esi, esi
		jz wyswietl
		mov byte PTR znaki [esi], 20H 
		dec esi 
		jmp wypeln
	wyswietl:
		mov byte PTR znaki [0], 0AH 
		mov byte PTR znaki [11], 0AH 
		
		push dword PTR 12 
		push dword PTR OFFSET znaki
		push dword PTR 1
		call __write 
		add esp, 12 

	POPA
	RET
wyswietl_EAX ENDP

wczytaj_do_EAX_hex PROC
	; wczytywanie liczby szesnastkowej z klawiatury � liczba po
	; konwersji na posta� binarn� zostaje wpisana do rejestru EAX
	; po wprowadzeniu ostatniej cyfry nale�y nacisn�� klawisz
	; Enter
	push ebx
	push ecx
	push edx
	push edi
	push ebp
	; rezerwacja 12 bajt�w na stosie przeznaczonych na tymczasowe	
	; przechowanie cyfr szesnastkowych wy�wietlanej liczby
	sub esp, 12 ; rezerwacja poprzez zmniejszenie ESP
	mov esi, esp ; adres zarezerwowanego obszaru pami�ci
	push dword PTR 10 ; max ilo�� znak�w wczytyw. liczby
	push esi ; adres obszaru pami�ci
	push dword PTR 0; numer urz�dzenia (0 dla klawiatury)
	call __read ; odczytywanie znak�w z klawiatury
	; (dwa znaki podkre�lenia przed read)
	add esp, 12 ; usuni�cie parametr�w ze stosu
	mov eax, 0 ; dotychczas uzyskany wynik
	mov ecx, 0
	pocz_konw:
		mov cl, [esi] ; pobranie kolejnego bajtu
		inc esi ; inkrementacja indeksu
		;cmp cl, 10 ; sprawdzenie czy naci�ni�to Enter
		cmp cl, '+'
		je gotowe ; skok do ko�ca podprogramu
		; sprawdzenie czy wprowadzony znak jest cyfr� 0, 1, 2 , ..., 9
		cmp cl, '0'
		jb pocz_konw ; inny znak jest ignorowany
		cmp cl, '9'
		ja sprawdzaj_dalej
		sub cl, '0' ; zamiana kodu ASCII na warto�� cyfry
	dopisz:
		;shl eax, 4 ; przesuni�cie logiczne w lewo o 4 bity
		;or al, cl ; dopisanie utworzonego kodu 4-bitowego
		mov ebx,12 ;podstawa systemu ktory wczytujemy~!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		mul ebx
		;imul eax, eax, 12

		add eax, ecx
		; na 4 ostatnie bity rejestru EAX
		jmp pocz_konw ; skok na pocz�tek p�tli konwersji
		; sprawdzenie czy wprowadzony znak jest cyfr� A, B, ..., F
	sprawdzaj_dalej:
		cmp cl, 'A'
		jb pocz_konw ; inny znak jest ignorowany
		cmp cl, 'F'
		ja sprawdzaj_dalej2
		sub cl, 'A' - 10 ; wyznaczenie kodu binarnego
		jmp dopisz
		; sprawdzenie czy wprowadzony znak jest cyfr� a, b, ..., f
		sprawdzaj_dalej2:
		cmp cl, 'a'
		jb pocz_konw ; inny znak jest ignorowany
		cmp cl, 'f'
		ja pocz_konw ; inny znak jest ignorowany
		sub cl, 'a' - 10
		jmp dopisz
	gotowe:
		; zwolnienie zarezerwowanego obszaru pami�ci
		add	esp, 12
		pop ebp
		pop edi
		pop edx
		pop ecx
		pop ebx
		ret
wczytaj_do_EAX_hex ENDP

wczytaj_do_EBX_hex PROC
	; wczytywanie liczby szesnastkowej z klawiatury � liczba po
	; konwersji na posta� binarn� zostaje wpisana do rejestru EAX
	; po wprowadzeniu ostatniej cyfry nale�y nacisn�� klawisz
	; Enter
	push eax
	push ecx
	push edx
	push esi
	push edi
	push ebp
	; rezerwacja 12 bajt�w na stosie przeznaczonych na tymczasowe	
	; przechowanie cyfr szesnastkowych wy�wietlanej liczby
	;sub esp, 12 ; rezerwacja poprzez zmniejszenie ESP
	;mov esi, esp ; adres zarezerwowanego obszaru pami�ci
	;push dword PTR 10 ; max ilo�� znak�w wczytyw. liczby
	;push esi ; adres obszaru pami�ci
	;push dword PTR 0; numer urz�dzenia (0 dla klawiatury)
	;call __read ; odczytywanie znak�w z klawiatury
	; (dwa znaki podkre�lenia przed read)
	;add esp, 12 ; usuni�cie parametr�w ze stosu
	mov ebx, 0 ; dotychczas uzyskany wynik
	mov ecx, 0
	pocz_konw:
		mov cl, [esi] ; pobranie kolejnego bajtu
		inc esi ; inkrementacja indeksu
		cmp cl, 10 ; sprawdzenie czy naci�ni�to Enter
		je gotowe ; skok do ko�ca podprogramu
		; sprawdzenie czy wprowadzony znak jest cyfr� 0, 1, 2 , ..., 9
		cmp cl, '0'
		jb pocz_konw ; inny znak jest ignorowany
		cmp cl, '9'
		ja sprawdzaj_dalej
		sub cl, '0' ; zamiana kodu ASCII na warto�� cyfry
	dopisz:
		;shl eax, 4 ; przesuni�cie logiczne w lewo o 4 bity
		;or al, cl ; dopisanie utworzonego kodu 4-bitowego
		;mov eax,12
		imul ebx, ebx,12
		;imul eax, eax, 12

		add ebx, ecx
		; na 4 ostatnie bity rejestru EAX
		jmp pocz_konw ; skok na pocz�tek p�tli konwersji
		; sprawdzenie czy wprowadzony znak jest cyfr� A, B, ..., F
	sprawdzaj_dalej:
		cmp cl, 'A'
		jb pocz_konw ; inny znak jest ignorowany
		cmp cl, 'F'
		ja sprawdzaj_dalej2
		sub cl, 'A' - 10 ; wyznaczenie kodu binarnego
		jmp dopisz
		; sprawdzenie czy wprowadzony znak jest cyfr� a, b, ..., f
		sprawdzaj_dalej2:
		cmp cl, 'a'
		jb pocz_konw ; inny znak jest ignorowany
		cmp cl, 'f'
		ja pocz_konw ; inny znak jest ignorowany
		sub cl, 'a' - 10
		jmp dopisz
	gotowe:
		; zwolnienie zarezerwowanego obszaru pami�ci
		;add	esp, 12
		pop ebp
		pop edi
		pop esi
		pop edx
		pop ecx
		pop eax
		ret
wczytaj_do_EBX_hex ENDP

_main PROC

	call wczytaj_do_EAX_hex

	call wczytaj_do_EBX_hex


	add eax, ebx

	call wyswietl_EAX

	push 0
	call _ExitProcess@4
_main ENDP
END