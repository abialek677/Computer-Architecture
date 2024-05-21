.686
.model flat

public _matrix

extern _malloc : PROC

.data

intRozmiar dd 4 ;zmienna do obliczania przeskakiwania kolumn w tablicy intow
doubleRozmiar dd 8 ; zmienna do obliczania przeskakiwania rzedow w tablicy doubli
rzedy dd 1
kolumny dd 1

.code

;extern float* matrix(double* A, int* B, unsigned int k, unsigned int l, unsigned int m); l to wysokosc maciery 2 i szerokosc 1
; finalny wymiar macierzy to k x m
_matrix PROC
push ebp
mov ebp, esp
push ebx
push edi
push esi ;prolog

mov eax, [ebp+16] ; zmienna k (wysokosc wektora wyjsciowego)
mul dword ptr [ebp+24] ;zmienna m (szerokosc wektora wyjsciowego)

mov ebx, 4 ; rozmiar inta
mul ebx
push eax ; liczba bajtow finalnego wektora (liczba komorek*4)
call _malloc
add esp, 4

mov ebx, eax ;przechowanie adresu zwracanej tablicy

mov edx, [ebp + 8] ; adres tablicy A double
mov eax, [ebp + 12] ;adres tablicy B int

mov ecx, [ebp + 20] ; k (wysokosc A)/tyle razy wykonywaæ siê beda operacje dla jedej komorki w macierzy wynikowej

mov edi, [ebp+16] ; l (szerokosc A, wysokosc B)
mov esi, [ebp+24] ; m (szerokosc B)


imul ecx, doubleRozmiar ; obliczanie przeskoku w pamieci miedzy wierszami w taliby doubli
mov doubleRozmiar, ecx ; alokacja przeskoku
mov ecx, [ebp + 20] 

imul esi, intRozmiar ; obliczanie przeskoku w pamieci miedzy kolumnami w tablicy intow
mov intRozmiar, esi ; alokacja przeskoku
mov esi, [ebp+24] 


finit
push ebx ;przechowanie adresu zwracanej tablicy na stosie
mainptl:
	fldz
	ptlLicz:
		fld qword ptr [edx] ; pobranie wartosci na stos koprocesora z tablicy doubli
		fild dword ptr [eax] ; pobranie wartosci na stos koprocesora z tablicy intow
		add edx, 8 ; przeskoczenie doubla w wierszu
		add eax, intRozmiar ; przeskoczenie inta w kolumnie
		fmul
		fadd				;obliczanie wartosci komorki
	loop ptlLicz
	fstp dword ptr [ebx]	;umieszczenie wartosci obliczonej z wierzcholka stosu do pamieci w odpowiednim miejscu
	add ebx, 4				;przejscie do kolejnej komorki w pamieci
	cmp esi, kolumny 
	jne koniecKolumny		;sprawdzenie czy to ostatnia sprawdzana kolumna dla danego wierszu
	cmp edi, rzedy			;sprawdzanie czy dany wiersz jest ostatni(jesli tak skoncz)
	je koniec

koniecRzedu:
mov kolumny, 1				;zerowanie licznika kolumn
mov eax, doubleRozmiar		;uzycie pomocniczo rejestru dla przeskoku
inc rzedy
add [ebp+8], eax			;modyfikacja w adresie pod ebp+8, przeskok rzedu
mov edx, [ebp+8]			;adres kolejnego rzedu w edx

mov eax, [ebp + 12]			; ponowne ustawienie eax na pierwszej kolumnie
mov ecx, [ebp + 20]			; reset licznika operacji dla jednej komorki

jmp mainptl
koniecKolumny:

mov eax, 4		;rozmiar inta
mul kolumny		; obliczanie przeskoku miedzy kolumnami


mov edx, [ebp + 8] ;reset edx na pierwszy wyraz rzadu
add eax, [ebp + 12]	;dodanie adresu (przeskok wzgledem pierwszej kolumny)


mov ecx, [ebp + 20]		; reset licznika operacji dla jednej komorki
inc kolumny ;zwiekszenie licznika kolumn

jmp mainptl
koniec:
pop eax		;odtworzenie adresu wyniku ze stosu
pop esi
pop edi
pop ebx
pop ebp
ret
_matrix ENDP
END

