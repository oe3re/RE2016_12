INCLUDE Irvine32.inc
INCLUDE Macros.inc
INCLUDE Definitions.inc

.data
endl EQU <0dh, 0ah>
BufSize = 80

messageHello LABEL BYTE
BYTE "Use arrows to move cursor or draw, INSERT to toggle between ", endl
BYTE "setting cursor position and drawing. Press ENTER to end the program. ", endl
BYTE "Default move value is 20. To change press F1. ", endl
BYTE "Press ENTER to start the program...", endl
messageSizeHello DWORD($ - messageHello)

messageMoveSize LABEL BYTE
BYTE "Move value?", endl
messageMoveSizeSize DWORD($ - messageMoveSize)

consoleHandle HANDLE 0
bytesWritten  DWORD ?
buffer BYTE BufSize DUP(? ), 0, 0
stdInHandle HANDLE ?
bytesRead DWORD ?

.code

;Writes welcome message and invokes SetMoveSize if F1 is pressed

Welcome PROC,
	moveSize : PTR WORD
		
INVOKE GetStdHandle, STD_OUTPUT_HANDLE
mov consoleHandle, eax

INVOKE WriteConsole, consoleHandle, ADDR messageHello, messageSizeHello, ADDR bytesWritten, 0

Hello : mov	eax, 10
	    call Delay
	    call ReadKey
	    cmp ax, 1C0Dh
	    je Finish
	    cmp ax, 3B00h
	    jne Hello
	    INVOKE SetMoveSize, moveSize

Finish : ret
Welcome ENDP

SetMoveSize PROC,
	moveSize : PTR WORD

call Clrscr
INVOKE WriteConsole, consoleHandle, ADDR messageMoveSize, messageMoveSizeSize, ADDR bytesWritten, 0
INVOKE GetStdHandle, STD_INPUT_HANDLE
mov stdInHandle, eax
INVOKE ReadConsole, stdInHandle, ADDR buffer, BufSize, ADDR bytesRead, 0
mov edx, OFFSET buffer
mov ecx, bufSize
call ParseInteger32
mov ebx, moveSize
cmp ax, 30h
ja  Finish
mov WORD PTR [ebx], ax

Finish : ret
SetMoveSize ENDP

END