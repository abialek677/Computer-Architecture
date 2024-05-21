.686
.model flat

extern __write : PROC
extern __read : PROC
extern _ExitProcess@4 : PROC
public _main

.data
obszar db 12 dup (?)
dziesiec dd 10 ; mno¿nik
podstawa dd 12
dekoder db '0123456789AB'

.code
	wyswietl_EAX_12 PROC
	pusha

	sub esp, 12
	mov esi, esp

	mov byte ptr [esi], 10
	inc esi
	ptl:
		mov edx, 0
		div podstawa
		mov cl,dekoder[edx]
		mov [esi], cl
		inc esi
		cmp eax,0
		jnz ptl

		call wyswietl_co_cl

	add esp, 12
	popa ; odtworzenie rejestrów
	ret ; powrót z podprogramu
wyswietl_EAX_12 ENDP


wyswietl_co_cl PROC
	mov cl,4 ;co ile spacja
	mov bl,0 ;licznik wypisanych liter bez spacji
	mov edi,0 ;index poczatkowy wyniku
	sub esp,24 ;rezerwacja miejsca na wynik z spacjami
	mov eax,esp ;zapisanie adresu wyniku
	dec esi
	dal:
		xor edx,edx ;zerowanie edx
		mov dl,[esi] 
		cmp dl,10
		je koniec
		mov [eax][edi],dl ;
		dec esi ;teraz idziemy od poczatku do konca az nie napotkamy 10
		inc bl ;ilosc znaków bez spacji
		inc edi ;kolejny index wyniku
		cmp bl,cl ;sprawdzamy czy wypisac spacje
		jne dal
		mov byte ptr [eax][edi],20h ;wypisujemy spacje
		inc edi ;nastepny index
		mov bl,0 ;zerujemy licznik
		jmp dal

	koniec:

	push edi ;ilosc znakow
	push eax ;adres
	push 1
	call __write
	add esp,36


	ret
wyswietl_co_cl ENDP


wczytaj_do_EAX PROC

	push ebx
	push edx
	push ecx
	; max iloœæ znaków wczytywanej liczby
	push dword PTR 12
	push dword PTR OFFSET obszar ; adres obszaru pamiêci
	push dword PTR 0; numer urz¹dzenia (0 dla klawiatury)
	call __read ; odczytywanie znaków z klawiatury
	; (dwa znaki podkreœlenia przed read)
	add esp, 12 ; usuniêcie parametrów ze stosu
	; bie¿¹ca wartoœæ przekszta³canej liczby przechowywana jest
	; w rejestrze EAX; przyjmujemy 0 jako wartoœæ pocz¹tkow¹
	mov eax, 0
	mov ebx, OFFSET obszar ; adres obszaru ze znakami
	pobieraj_znaki:
		mov cl, [ebx] ; pobranie kolejnej cyfry w kodzie
		; ASCII
		inc ebx ; zwiêkszenie indeksu
		cmp cl,10 ; sprawdzenie czy naciœniêto Enter
	je byl_enter ; skok, gdy naciœniêto Enter
		sub cl, 30H ; zamiana kodu ASCII na wartoœæ cyfry
		movzx ecx, cl ; przechowanie wartoœci cyfry w
		; rejestrze ECX
		; mno¿enie wczeœniej obliczonej wartoœci razy 10
		mul dword PTR dziesiec
		add eax, ecx ; dodanie ostatnio odczytanej cyfry
	jmp pobieraj_znaki ; skok na pocz¹tek pêtli
	byl_enter:

	pop ecx
	pop edx
	pop ebx

	RET
wczytaj_do_EAX ENDP


_main PROC
	

	call wczytaj_do_EAX

	call wyswietl_EAX_12

	push 0
	call _ExitProcess@4

_main ENDP
END