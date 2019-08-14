Volume_Up::
Send ^c
return
Volume_Down::
Send ^v
return
Volume_Mute::
Send {Enter}
return
#n::
; Activate an existing notepad.exe window, or open a new one
if WinExist("ahk_exe notepad.exe")
{
    WinActivate, ahk_exe notepad.exe
    MsgBox Notepad has opened
    }
else
	Run, notepad.exe
return
::btw::
MsgBox, You typed btw.
return
