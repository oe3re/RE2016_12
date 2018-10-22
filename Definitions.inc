SetMoveSize PROTO moveSize : PTR WORD
Welcome PROTO moveSize : PTR WORD

SetCursorPos PROTO ScreenLength : WORD, ScreenHeight : WORD

GoUp PROTO ScreenHeight : WORD
GoDown PROTO ScreenHeight : WORD
GoRight PROTO ScreenLength : WORD
GoLeft PROTO ScreenLength : WORD

Draw PROTO moveSize : WORD, ScreenLength : WORD, ScreenHeight : WORD

Up PROTO moveSize : WORD, ScreenLength : WORD, ScreenHeight : WORD
Down PROTO moveSize : WORD, ScreenLength : WORD, ScreenHeight : WORD
Left PROTO moveSize : WORD, ScreenLength : WORD, ScreenHeight : WORD
Right PROTO moveSize : WORD, ScreenLength : WORD, ScreenHeight : WORD

DrawVerticalLine PROTO ScreenHeight : WORD
DrawHorizontalLine PROTO ScreenLength : WORD

ProgramLoop PROTO
