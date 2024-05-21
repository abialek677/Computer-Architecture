.686
.model flat

extern __write : PROC
extern __read : PROC
extern _ExitProcess@4 : PROC

public _main


.data
inputBase dd 10
outputBase dd 4
characterCount dd 10
decoder db '0123456789ABCDEFGHIJKLMNOPQRSTUW'



.code
wczytaj_do_EAX_bestia PROC

	push ebx
	push ecx
	push edx
	push esi
	push edi
	push ebp


	sub esp, 12 ; dynamic memory for input
	mov esi, esp 


	push dword PTR 9 ; no. of characters
	push esi		  ; adress to store in
	push dword PTR 0  ; code for keyboard
	call __read
	add esp, 12 ; remove arguments from stack


	mov eax, 0 ; stored output
	mov ecx, 0 ; clearing ecx
	conversion:
		mov cl, [esi] ; getting next byte
		inc esi ; increasing to get next byte
		cmp cl, 10 ; checking for Enter
		je done ; jump to the end
		; checking if character is 0...n
		cmp cl, '0'
		jb conversion ; other characters are ignored
		cmp cl, '9'
		ja check_letter
		sub cl, '0' ; changing from ascii code to value
	dopisz:
		mov ebx, inputBase	; formula from instruction
		mul ebx				; (((a)*base+b)*base+c)*base....
							
		add eax, ecx		
		jmp conversion		
	check_letter:
		cmp cl, 'A'
		jb conversion ; other characters are ignored
		cmp cl, 'W'
		ja check_letter2
		sub cl, 'A' - 10 ; calculating binary code
		jmp dopisz
		check_letter2:
		cmp cl, 'a'
		jb conversion ; other characters are ignored
		cmp cl, 'w'
		ja conversion  ; other characters are ignored
		sub cl, 'a' - 10 ; calculating binary code
		jmp dopisz
	done:
		add	esp, 12
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
		div outputBase
		mov cl,decoder[edx]
		mov [esi], cl
		inc esi
		cmp eax,0
	jnz ptl



	mov edi,0 ;index poczatkowy wyniku
	sub esp,12 ;rezerwacja miejsca na wynik
	mov eax,esp ;zapisanie adresu wyniku

	dal:
		mov edx, 0 ;zerowanie edx
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


	
	mov ecx, characterCount
	sub ecx,edi
	sub esp, 8
	mov ebx, ecx
	ptll:
		dec eax
		mov [eax], byte ptr 30H
		inc edi
	loop ptll
	inc eax
	dec edi

	push edi ; character count
	push eax ; adress
	push 1
	call __write

	add esp, 44
	popa ; odtworzenie rejestrów
	ret ; powrót z podprogramu
wyswietl_EAX_bestia ENDP

_main PROC


	call wczytaj_do_EAX_bestia


	call wyswietl_EAX_bestia

	push 0
	call _ExitProcess@4

_main ENDP
END