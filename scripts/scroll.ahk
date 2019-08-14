applicationname=Scroll
Menu, Tray, Icon, C:\Program Files (x86)\AutoHotkey\Compiler\Icon\scroll.png
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
