INCLUDE Irvine32.inc
INCLUDE Macros.inc
INCLUDE Definitions.inc

.data
outHandle DWORD ?
xyPos COORD <0, 0>
consoleInfo CONSOLE_SCREEN_BUFFER_INFO <>

.code

DrawVerticalLine PROC,
	ScreenHeight : WORD

mov WORD PTR xyPos[2], 0
mov bx, screenHeight

    L : INVOKE SetConsoleCursorPosition, outHandle, xyPos
	mov  al, 0DBh
	call WriteChar
	dec bx
	cmp bx, 0
	jz Finish
	add WORD PTR xyPos[2], 1
	jmp	L

Finish : ret
DrawVerticalLine ENDP

DrawHorizontalLine PROC,
	ScreenLength : WORD

mov WORD PTR xyPos[0], 0
mov bx, screenLength

    L : INVOKE SetConsoleCursorPosition, outHandle, xyPos
	mov  al, 0DBh
	call WriteChar
	dec bx
	cmp bx, 0
	jz Finish
	add WORD PTR xyPos[0], 1
	jmp	L

Finish : ret
DrawHorizontalLine ENDP

Draw PROC,
	moveSize : WORD, ScreenLength : WORD, ScreenHeight : WORD

INVOKE GetStdHandle, STD_OUTPUT_HANDLE
mov outHandle, eax

INVOKE GetConsoleScreenBufferInfo, outHandle, ADDR consoleInfo
mov ax, WORD PTR consoleInfo[4]
mov WORD PTR xyPos[0], ax
mov ax, WORD PTR consoleInfo[6]
mov WORD PTR xyPos[2], ax

       L : mov	eax, 10
       call Delay
       call	ReadKey
       jz	L
       cmp ax, 4B00h
       jz	LeftKey
       cmp ax, 4D00h
       jz RightKey
       cmp ax, 4800h
       jz UpKey
       cmp ax, 5000h
       jz DownKey
       cmp ax, 5200h
       jz Finish
       cmp ax, 1C0Dh
       jz endProgram
       jmp	L

	LeftKey : INVOKE Left, moveSize, ScreenLength, ScreenHeight
	       jmp L
	RightKey : INVOKE Right, moveSize, ScreenLength, ScreenHeight
			jmp L
	UpKey : INVOKE Up, moveSize, ScreenLength, ScreenHeight
		 jmp L
	DownKey : INVOKE Down, moveSize, ScreenLength, ScreenHeight
	       jmp L

	endProgram : INVOKE ExitProcess, 0

Finish: ret
Draw ENDP

Left PROC,
	moveSize : WORD, ScreenLength : WORD, ScreenHeight : WORD

mov dx, moveSize
sub WORD PTR xyPos[0], dx
mov bx, screenLength
cmp WORD PTR xyPos[0], bx
ja LeftException
jmp DrawVertical
LeftException : add WORD PTR xyPos[0], dx
jmp DrawVertical

DrawVertical : INVOKE DrawVerticalLine, ScreenHeight

ret
Left ENDP

Right PROC,
	moveSize : WORD, ScreenLength : WORD, ScreenHeight : WORD
		
mov dx, moveSize
add WORD PTR xyPos[0], dx
mov bx, screenLength
cmp WORD PTR xyPos[0], bx
ja RightException
jmp DrawVertical
RightException : sub WORD PTR xyPos[0], dx
jmp DrawVertical

DrawVertical : INVOKE DrawVerticalLine, ScreenHeight

ret 
Right ENDP

Up PROC,
	moveSize : WORD, ScreenLength : WORD, ScreenHeight : WORD

mov dx, moveSize
sub WORD PTR xyPos[2], dx
mov bx, screenHeight
cmp WORD PTR xyPos[2], bx
ja UpException
jmp DrawHorizontal
UpException : add WORD PTR xyPos[2], dx
jmp DrawHorizontal

DrawHorizontal : INVOKE DrawHorizontalLine, ScreenLength

ret
Up ENDP

Down PROC,
	moveSize : WORD, ScreenLength : WORD, ScreenHeight : WORD

mov dx, moveSize
add WORD PTR xyPos[2], dx
mov bx, screenHeight
cmp WORD PTR xyPos[2], bx
ja DownException
jmp DrawHorizontal
DownException : sub WORD PTR xyPos[2], dx
jmp DrawHorizontal

DrawHorizontal : INVOKE DrawHorizontalLine, ScreenLength

ret 
Down ENDP

END