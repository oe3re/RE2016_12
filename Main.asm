INCLUDE Irvine32.inc
INCLUDE Macros.inc
INCLUDE Definitions.inc



.data
moveSize WORD 20
ScreenLength  WORD  60
ScreenHeight  WORD  60
outHandle    DWORD ?
windowRect SMALL_RECT <0, 0, 60, 60>

.code

ProgramLoop PROC

SetPos : INVOKE SetCursorPos, ScreenLength, ScreenHeight	    
         INVOKE Draw, moveSize, ScreenLength, ScreenHeight
		    jmp SetPos
ret
ProgramLoop ENDP

main PROC

INVOKE Welcome, OFFSET moveSize
call Clrscr

INVOKE GetStdHandle, STD_OUTPUT_HANDLE
mov outHandle, eax
INVOKE SetConsoleWindowInfo, outHandle, TRUE, ADDR windowRect

INVOKE ProgramLoop

INVOKE ExitProcess, 0
main ENDP
END main