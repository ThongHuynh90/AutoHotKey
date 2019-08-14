; Long press for NumLock
; Long press F1 for copy, F2 for pase
; F3 f4 for un/redo
; AOE for ÅØÆ
; Volume keys for scroll



applicationname=Scroll
Menu, Tray, Icon, E:\OneDrive - Ho Chi Minh City University of Technology\Hobby\AutoHotKey\icons\scroll.png
Volume_Up::
Send {WheelUp}
return

Volume_Down::
Send {WheelDown}
return

Volume_Mute::
Send ^c
return

^Volume_Up::
Send {Home}
return

^Volume_Down::
Send {End}
return


$*o::
Send {Blind}{o}
KeyWait, o, T0.5
If ErrorLevel {
	If GetKeyState("Shift", "P")
	Send {BackSpace}{Ø}
	else
	Send {BackSpace}{ø}
	KeyWait, o
}
return



$*a::
Send {Blind}{a}
KeyWait, a, T0.5
If ErrorLevel {
	If GetKeyState("Shift", "P")
	Send {BackSpace}{Å}
	else
	Send {BackSpace}{å}
	KeyWait, a
}
return

$*e::
Send {Blind}{e}
KeyWait, e, T0.5
If ErrorLevel {
	If GetKeyState("Shift", "P")
	Send {BackSpace}{Æ}
	else
	Send {BackSpace}{æ}
	KeyWait, e
}
return

$*F1::

KeyWait, F1, T0.5
If ErrorLevel {
	Send {F1}
	KeyWait, F1
}
else
{
Send ^c
ToolTip, Copied
SetTimer, RemoveToolTip, -200
}
return

$*F2::

KeyWait, F2, T0.5
If ErrorLevel {
	Send {F2}
	KeyWait, F2
}
else
{
Send ^v
ToolTip, Paste
SetTimer, RemoveToolTip, -200
}
return

RemoveToolTip:
ToolTip
return

F3::
Send ^z
return 


F4::
Send ^y
return 

Launch_Media::
MsgBox Notepad has opened
return


$*NumLock::
IsNumOn := GetKeyState("NumLock" , "T") ; remember quote signs
if (IsNumOn) { ;NumLock is currently on
	KeyWait, NumLock, T1 ; wait 1 second
	If ErrorLevel { ; long pressed
		SetNumLockState, Off 
		ToolTip, NumLock off
		KeyWait, NumLock
}
	else { ; short pressed
	ToolTip, Still on `, hold 1s to off 
	}
}
else{ ;NumLock is currently off
	SetNumLockState, On  
	ToolTip, NumLock on
}
SetTimer, RemoveToolTip, -500
return
