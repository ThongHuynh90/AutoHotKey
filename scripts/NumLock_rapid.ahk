applicationname=NumLockRapid
Menu, Tray, Icon, C:\Program Files (x86)\AutoHotkey\Compiler\Icon\iconNumlock.png
curstate=1
SetNumLockState,On

TRAYMENU:
Menu,Tray,NoStandard 
Menu,Tray,DeleteAll 
Menu,Tray,Add,Lock Your Numlock,ABOUT
Menu,Tray,Add,E&xit,EXIT
Menu,Tray,Tip,%applicationname%
Return 


NumLock::
Gosub,THEREST
return


THEREST:
counter=1000
 if( curstate=0 )
  {
	SetNumLockState,On
	curstate=1
  }
  else
  {
	Loop,10
	{
		Sleep,100
		counter-=100
		GetKeyState,state,NumLock,P
		If state=U
		Break
	}
	
	If counter=0
	{
		If (curstate=1)
		{
			MsgBox, Disabled Numlock
			SetNumLockState,Off
			curstate=0
		}
	}
}
return


ABOUT:
MsgBox, Long press NumLock to disable NumLock
Return


EXIT:
ExitApp
