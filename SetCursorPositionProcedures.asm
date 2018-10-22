INCLUDE Irvine32.inc
INCLUDE Macros.inc
INCLUDE Definitions.inc

.data 
outHandle DWORD ?
xyPos COORD <0,0>

.code

SetCursorPos PROC,
	ScreenLength : WORD, ScreenHeight : WORD

INVOKE GetStdHandle, STD_OUTPUT_HANDLE
mov outHandle, eax

SetPos : INVOKE SetConsoleCursorPosition, outHandle, xyPos
	     mov eax, 10
	     call Delay
	     call ReadKey
	     jz SetPos
	     cmp ax, 4B00h
	     jz	LeftKey
	     cmp ax, 4D00h
	     jz	RightKey
	     cmp ax, 4800h
	     jz	UpKey
	     cmp ax, 5000h
	     jz	DownKey
	     cmp ax, 5200h
	     jz Finish
	     cmp ax, 1C0Dh
	     jz endProgram
	     jmp SetPos

	LeftKey: INVOKE GoLeft, ScreenLength
	jmp SetPos

	RightKey: INVOKE GoRight, ScreenLength
	jmp SetPos

	UpKey: INVOKE GoUp, ScreenHeight
	jmp SetPos

	DownKey: INVOKE GoDown, ScreenHeight
	jmp SetPos

	endProgram : INVOKE ExitProcess, 0

Finish: ret
SetCursorPos ENDP

GoLeft PROC,
	ScreenLength : WORD

sub WORD PTR xyPos[0], 1
mov bx, screenLength
cmp WORD PTR xyPos[0], bx
ja LeftException
jmp Finish
LeftException : add WORD PTR xyPos[0], 1
jmp Finish

Finish: ret
GoLeft ENDP

GoRight PROC,
	ScreenLength : WORD

add WORD PTR xyPos[0], 1
mov bx, screenLength
cmp WORD PTR xyPos[0], bx
ja RightException
jmp Finish
RightException : sub WORD PTR xyPos[0], 1
jmp Finish

Finish: ret
GoRight ENDP

GoUp PROC,
	ScreenHeight : WORD

sub WORD PTR xyPos[2], 1
mov bx, screenHeight
cmp WORD PTR xyPos[2], bx
ja UpException
jmp Finish
UpException : add WORD PTR xyPos[2], 1
jmp Finish

Finish: ret
GoUp ENDP

GoDown PROC,
	ScreenHeight : WORD

add WORD PTR xyPos[2], 1
mov bx, screenHeight
cmp WORD PTR xyPos[2], bx
ja DownException
jmp Finish
DownException : sub WORD PTR xyPos[2], 1
jmp Finish

Finish: ret
GoDown ENDP

END