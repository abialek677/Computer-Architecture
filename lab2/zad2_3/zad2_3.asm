.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC
extern _MessageBoxW@16 : PROC
public _main
.data
tytul dw 'Z','n','a','k','i', 0

tekst dw 'T','o',' ','j','e','s','t',' ','r','a','k','i','e','t','a',' ', 0D83DH ,0DE80H,' ','i',' ','s','k','m',' ', 0D83DH, 0DE86H

.code
_main PROC

push 0

push OFFSET tytul

push OFFSET tekst

push 0

call _MessageBoxW@16



 push 0 ; kod powrotu programu
 call _ExitProcess@4
_main ENDP
END