.686
.model flat

extern __write : PROC
extern __read : PROC
extern _ExitProcess@4 : PROC

public _main


.data
podstawaWyjscia dd 10
podstawaWejscia dd 10
dekoder db '0123456789ABCDEFGHIJKLMNOPQRSTUW'



.code
wczytaj_do_EAX_bestia PROC


	push ebx
	push ecx
	push edx
	push esi
	push edi
	push ebp


	sub esp, 24 
	mov esi, esp 


	push dword PTR 10 
	push esi 
	push dword PTR 0
	call __read
	add esp, 12 ; usuniêcie parametrów ze stosu


	mov eax, 0 ; dotychczas uzyskany wynik
	mov ecx, 0
	pocz_konw:
		mov cl, [esi] ; pobranie kolejnego bajtu
		inc esi ; inkrementacja indeksu
		cmp cl, 10 ; sprawdzenie czy naciœniêto Enter
		je gotowe ; skok do koñca podprogramu
		; sprawdzenie czy wprowadzony znak jest cyfr¹ 0, 1, 2 , ..., 9
		cmp cl, '0'
		jb pocz_konw ; inny znak jest ignorowany
		cmp cl, '9'
		ja sprawdzaj_dalej
		sub cl, '0' ; zamiana kodu ASCII na wartoœæ cyfry
	dopisz:
		mov ebx, podstawaWejscia
		mul ebx
		;imul eax, eax, 12

		add eax, ecx
		jmp pocz_konw
	sprawdzaj_dalej:
		cmp cl, 'A'
		jb pocz_konw ; inny znak jest ignorowany
		cmp cl, 'G'
		ja sprawdzaj_dalej2
		sub cl, 'A' - 10 ; wyznaczenie kodu binarnego
		jmp dopisz
		sprawdzaj_dalej2:
		cmp cl, 'a'
		jb pocz_konw ; inny znak jest ignorowany
		cmp cl, 'g'
		ja pocz_konw ; inny znak jest ignorowany
		sub cl, 'a' - 10
		jmp dopisz
	gotowe:
		add	esp, 24
		pop ebp
		pop edi
		pop esi
		pop edx
		pop ecx
		pop ebx
		ret
wczytaj_do_EAX_bestia ENDP

wyswietl_EAX_bestia PROC
	pusha

	sub esp, 12
	mov esi, esp

	mov byte ptr [esi], 10
	inc esi

	ptl:
		mov edx, 0
		div podstawaWyjscia
		mov cl,dekoder[edx]
		mov [esi], cl
		inc esi
		cmp eax,0
	jnz ptl



	mov edi,0 ;index poczatkowy wyniku
	sub esp,24 ;rezerwacja miejsca na wynik z spacjami
	mov eax,esp ;zapisanie adresu wyniku

	dal:
		xor edx,edx ;zerowanie edx
		mov dl,[esi] 
		cmp dl,10
		je koniec
		mov [eax][edi],dl ;
		dec esi ;teraz idziemy od poczatku do konca az nie napotkamy 10
		inc edi ;kolejny index wyniku
		jmp dal

	koniec:
	inc eax
	dec edi


	push edi ;ilosc znakow
	push eax ;adres
	push 1
	call __write

	add esp, 48
	popa ; odtworzenie rejestrów
	ret ; powrót z podprogramu
wyswietl_EAX_bestia ENDP

_main PROC
	call wczytaj_do_EAX_bestia

	mov [edi], byte ptr 10
	push eax
	push 1
	push edi
	push 1
	call __write
	add esp, 12
	pop eax


	mov ecx, eax
	mov ebx, eax
	read:
		call wczytaj_do_EAX_bestia
		push eax
	loop read
	mov ecx, ebx
	pop edx
	dec ecx
	check_biggest:
	pop ebx
	cmp edx,ebx
	jb change_biggest

	loop check_biggest
	jmp koniec
	change_biggest:
	mov edx, ebx


	loop check_biggest

	koniec:
	mov eax, edx
	mov  [edi], byte ptr 10
	push eax
	push 1
	push edi
	push 1
	call __write
	add esp, 12
	pop eax
	
	call wyswietl_EAX_bestia


	push 0
	call _ExitProcess@4

_main ENDP
END