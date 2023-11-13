;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Name:
; Get formated code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#SingleInstance force
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;;;;;;;;;;;;;;;;;;;;;
formatedCode := ""
CodeIsFormated := 0
itsAlredyInClipboard := 0

Gui, Color, 121212
Gui -DPIScale
;Gui +AlwaysOnTop
Gui, Font, s23
Gui, Add, Text, cWhite x0 y10 w1500 h50 center , Get formated code
Gui, Font, s15
Gui, Add, Text, cWhite x10 y60 w700 h30 , Paste code for formating down here you can do (Ctrl+V)
Gui, Font, s10
Gui, Add, Edit, x10 y100 w735 h590 vcodeForFormating gFixFormating,
Gui, Font, s15
Gui, Add, Text, cWhite x755 y60 w900 h30 , Copy formated code you can just select (Ctrl+A) then (Ctrl+C)
Gui, Font, s10
Gui, Add, Edit, cWhite x755 y100 w735 h590 vformatedCode +ReadOnly ,
Gui, Font, s17
Gui, Add, Button, x10 y700 h50 w1000 gButton, Format Code
Gui, Add, Button, x1020 y700 h50 w470 gCopyToClipboard, Copy to Clipboard
Gui, Show, w1500 h760
Return

!^+F::
	Clipboard := "" ; Empty the clipboard
	Send, ^x
	ClipWait, 2
	If ErrorLevel
	{
		MsgBox, 262160, ERROR, The attempt to copy text onto the clipboard failed.
		Return
	}
	codeForFormating := Clipboard
	formatedCode := getFormatedCode(codeForFormating)
	Sleep, 10
	Clipboard := formatedCode
	ClipWait, 2
	If ErrorLevel
	{
		MsgBox, 262160, ERROR, The attempt to copy text onto the clipboard failed.
		Return
	}
	Sleep, 20
	Send, ^v
Return



CopyToClipboard:
	If (CodeIsFormated = 1) && (itsAlredyInClipboard = 0)
	{
		Clipboard := formatedCode
		formatedCode := ""
		itsAlredyInClipboard := 1
		Return
	}

	If (CodeIsFormated = 1) && (itsAlredyInClipboard = 1)
	{
		MsgBox, 262192, , Your formatted code is alReady in the clipboard.`nIf you have any problems whit it just format it again!
		Return
	}

	If (CodeIsFormated = 0) && (itsAlredyInClipboard = 0)
	{
		MsgBox, 262160, ERROR, You first have to format the code before copying it to the clipboard!!!
		Return
	}
Return

FixFormating:
	Gui, Submit, NoHide
	GuiControl, , codeForFormating, %codeForFormating%
Return

Button:
	Gui, Submit, NoHide
	formatedCode := ""
	formatedCode := getFormatedCode(codeForFormating)
	CodeIsFormated := 1
	GuiControl,, formatedCode, %formatedCode%
Return

GuiClose:
!L::
	ExitApp
Return

getFormatedCode(codeForFormating)
	{
		FileDelete, codeFromFile.txt
		FileAppend, %codeForFormating%, codeFromFile.txt
		Sleep, 10
		RunWait, ahk format script.ahk
		Sleep, 10
		FileRead, formatedCode, formatedCode.txt
		Return formatedCode
	}





