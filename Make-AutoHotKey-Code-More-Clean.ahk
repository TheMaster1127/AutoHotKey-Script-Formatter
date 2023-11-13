;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Name:
; Make-AutoHotKey-Code-More-Clean
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#SingleInstance force
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;;;;;;;;;;;;;;;;;;;;;





; YourRegex variable will hold the refined Regex pattern
FindCommentsWhitRegex := "^\s*;|^[^\s\t;]+[ \t]*;"
commentsInScript := 0

FileRead, badCode, badCode.txt
Loop, Parse, badCode, `n, `r
{



	isItAfunction()

	;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;

	thereIsaLable := 0
	; Check for label definition with or without comments
	If (RegExMatch(A_LoopField, "^\s*\w+\s*:\s*;")) {
		; Handle label with comment

		; Check for label definition with or without comments
		If (RegExMatch(A_LoopField, "^\s*\w+\s*:(\s*;|$)")) {
			; Handle label with comment or no extra characters after colon
			;MsgBox, Handle label with comment or no extra characters after colon`n%A_LoopField%`nAt line %A_Index%
			thereIsaLable := 1
		} Else If (RegExMatch(A_LoopField, "^\s*\w+\s*:$")) {
			; Handle label without comment or no extra characters after colon
			thereIsaLable := 1
		}

		If (thereIsaLable = 1)
		{
			MsgBox, Handle label with comment`n%A_LoopField%`nAt line %A_Index%
		}

		thereIsaLable := 0


	} Else If (RegExMatch(A_LoopField, "^\s*\w+\s*:")) {
		; Handle label without comment
		; Check for label definition with or without comments
		If (RegExMatch(A_LoopField, "^\s*\w+\s*:(\s*;|$)")) {
			; Handle label with comment or no extra characters after colon
			;MsgBox, Handle label with comment or no extra characters after colon`n%A_LoopField%`nAt line %A_Index%
			thereIsaLable := 1
		} Else If (RegExMatch(A_LoopField, "^\s*\w+\s*:$")) {
			; Handle label without comment or no extra characters after colon
			thereIsaLable := 1
		}


		If (thereIsaLable = 1)
		{
			MsgBox, Handle label without comment`n%A_LoopField%`nAt line %A_Index%
		}

	}

	;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;



	; A_LoopField contains the current parsed field
	If (RegExMatch(A_LoopField, FindCommentsWhitRegex)) {
		; Semicolon detected at the start or with spaces/tabs/nothing before
		;MsgBox, Semicolons detected; potential comments`n%A_LoopField%`nAt line %A_Index%
		commentsInScript++
	} Else {
		; No semicolon outside of comments
		;MsgBox, No semicolon outside of comments in the line`n%A_LoopField%`nAt line %A_Index%
	}


}

MsgBox, %commentsInScript%
ExitApp
Return

!L::
	ExitApp
Return





isItAfunction()
	{
		global
		foundFunc := 0


		; Trim leading and trailing spaces from the line
		line := StrReplace(A_LoopField, " ", "")

		; Check if the line starts with "if(" or "if (" or "else" or "else "
		If (SubStr(line, 1, 3) = "if(" or SubStr(line, 1, 4) = "if (" or line = "else" or line = "else ")
		{
			; MsgBox, The line starts with a valid pattern: %line%
			; Do something here if the pattern is detected
		}
		Else
		{

			; Regular expression to match AHK function pattern
			If (RegExMatch(A_LoopField, "i)^\s*\b\w+\b\s*\("))
			{
				; Check if there is an opening curly brace '{' on the same line or the next line
				;MsgBox, % A_LoopField
				Haystack := A_LoopField
				Needle := "{"
				IfInString, Haystack, %Needle%
				{
					;MsgBox, The string was found on the same line.
					foundFunc := 1
				}
				Else
				{
					nextLine := A_Index + 1
					FileReadLine, checkIfCurlyBraketOnNextLine, badCode.txt, %nextLine%

					Haystack := checkIfCurlyBraketOnNextLine
					Needle := "{"
					IfInString, Haystack, %Needle%
					{
						;MsgBox, The string was found on the next line.
						foundFunc := 1
					}


				}










				If (foundFunc = 1)
				{
					foundFunc := 0



					; Check if `; appears before {
					If (RegExMatch(Haystack, "`;.*{")) {
						; If `; appears before {, do something (e.g., set redcode to true)
						;MsgBox, Redcode detected`n%someVar%`nAt line %A_Index%
						redcode := true
					} Else {
						; If `; does not appear before {, do something else (e.g., set redcode to false)
						;MsgBox, No Redcode detected`n%someVar%`nAt line %A_Index%
						redcode := false
					}

					; Use the redcode variable as needed in your script
					If (redcode) {
						; Perform actions for redcode
						commentsInScript++
					} Else {
						foundFunc := 1

						semicolonAscii := 59

						; Check if a variable contains a semicolon
						If (InStr(Haystack, Chr(semicolonAscii))) {
							MsgBox, The string contains a semicolon.

							;MsgBox, The string was found on the next line.
							commentsInScript++
						}


					}









					If (foundFunc = 1)

					{

						MsgBox, Found AHK function on line %A_Index%: %A_LoopField%



					}
				}

			}

		}



	}










