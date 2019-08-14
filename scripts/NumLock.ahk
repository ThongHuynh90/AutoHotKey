;NumLock.ahk
;Slows down and extends the CapsLock key. 
; Also slows down F1, Insert, NumLock and ScrollLock
;
;Hold for 0.5 sec to toggle caps lock on or off.
;Hold for 1 sec to show a menu that converts selected text to 
; UPPER CASE, lower case, Title Case or iNVERT cASE.
;
;If the keyboard is idle for 120 seconds, CapsLock is turned off.
;
;Skrommel @2005

#NoEnv
#SingleInstance,Force
AutoTrim,Off 
StringCaseSense,On
SetBatchLines,-1
SetWinDelay,0

applicationname=NumLock
I_Icon = C:\Program Files (x86)\AutoHotkey\Compiler\Icon\iconNumlock.png
IfExist, %I_Icon%
  Menu, Tray, Icon, %I_Icon%
Gosub,READINI
Gosub,TRAYMENU

WinGet,oldid,ID,A

SetTimer,ACTIVEWIN,1000

time:=A_TickCount
Loop
{
  Input,key,L1 T1 V,{LControl}{RControl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{Capslock}{Numlock}{PrintScreen}{Pause}
  If (ErrorLevel<>"Timeout")
    time:=A_TickCount
  If (A_TickCount-time>=capslockidle*1000)
  {
    If capslockidle>0
    If (not GetKeyState("Numlock","T"))
    {
      SetNumLockState,On
      MsgBox, Numlock Enabled Again!
    }
    time:=A_TickCount
  }
}
Return


ACTIVEWIN:
WinGet,id,ID,A
WinGetClass,class,ahk_id %id%
If id=
  id=%oldid%
If class=Shell_TrayWnd
  id=%oldid%
If id=AutoHotkey
  id=%oldid%
oldid=%id%
Return


DELAY:
Gosub,TRAYTIP
hotkey=%A_ThisHotkey%
IfInString,hotkey,$
  StringTrimLeft,hotkey,hotkey,1
Gosub,THEREST
Return


THEREST:
counter=1000
Loop,10
{
  If showstatus=1
    ToolTip,%hotkey% in %counter% ms
  Sleep,100
  counter-=100
  GetKeyState,state,%hotkey%,P
  If state=U
    Break
}
If showstatus=1
  ToolTip,
If counter=0
If hotkey=F1
  Send,{%hotkey%}
Else
{
  GetKeyState,state,%hotkey%,T
  If state=U
  {
    If hotkey=NumLock
      SetNumLockState,On
    If hotkey=ScrollLock
      SetScrollLockState,On
    If hotkey=Insert
      Send,{%hotkey%}
    If showstatus=1
      ToolTip,%hotkey% On
  }
  Else
  {
    If hotkey=NumLock
      SetNumLockState,Off
    If hotkey=ScrollLock
      SetScrollLockState,Off
    If hotkey=Insert
      Send,{%hotkey%}
    If showstatus=1
      ToolTip,%hotkey% Off
  }
  SetTimer,TOOLTIPOFF,On
}
KeyWait,%hotkey%
Return




TRAYTIP:
status=
key=Insert
Gosub,GETSTATE
key=CapsLock
Gosub,GETSTATE
key=NumLock
Gosub,GETSTATE
key=ScrollLock
Gosub,GETSTATE
If showstatus=1
  TrayTip,Status,%status%,10
Return


GETSTATE:
GetKeyState,state,%key%,T
If state=D
  status=%status%%key%`n
Return

MENU:
Menu,convert,Add,E&xit,EXIT
Menu,convert,Show
Return



TRAYMENU:
Menu,Tray,NoStandard 
Menu,Tray,DeleteAll 
Menu,Tray,Add,Lock Your Numlock,ABOUT
Menu,Tray,Add,E&xit,EXIT
Menu,Tray,Tip,%applicationname%
Return 



TOOLTIPOFF:
If showstatus=1
  ToolTip,
SetTimer,TOOLTIPOFF,Off
Gosub,TRAYTIP
Return







ABOUT:
Return


99GuiClose:
  Gui,99:Destroy
  OnMessage(0x200,"")
  DllCall("DestroyCursor","Uint",hCur)
Return

WM_MOUSEMOVE(wParam,lParam)
{
  Global hCurs
  MouseGetPos,,,,ctrl
  If ctrl in Static13,Static17,Static21
    DllCall("SetCursor","UInt",hCurs)
  Return
}
Return

EXIT:
ExitApp



SETTINGS:
Gosub,READINI
Run,NumLock.ini
Return


READINI:
IfNotExist,NumLock.ini
{
  inifile=;NumLock.ini
  inifile=%inifile%`n`;[Settings]
  inifile=%inifile%`n`;capslockidle=120    `;0-999  0=Off  Seconds to wait before turning off CapsLock when the keyboard is idle
  inifile=%inifile%`n`;showstatus=1        `;0,1    0=Hide  1=Show  Hide or show the status windows
  inifile=%inifile%`n`;delaycapslock=1     `;0,1    0=Ignore CapsLock  1=Delay F1
  inifile=%inifile%`n`;delayf1=1           `;0,1    0=Ignore F1  1=Delay F1
  inifile=%inifile%`n`;delayinsert=1
  inifile=%inifile%`n`;delayscrolllock=1
  inifile=%inifile%`n`;delaynumlock=1
  inifile=%inifile%`n`;
  inifile=%inifile%`n`;ae=æ                `;Chars to replace=Chars to replace with
  inifile=%inifile%`n`;oe=ø                `;Special characters:
  inifile=%inifile%`n`;aa=å                `;  .space. .tab. .return. .newline. .comma. .semicolon.
  inifile=%inifile%`n`;AE=Æ
  inifile=%inifile%`n`;OE=Ø
  inifile=%inifile%`n`;AA=Å
  inifile=%inifile%`n`;AA=Å
  inifile=%inifile%`n`;.return..newline..return..newline.=  ;Removes empty lines 
  inifile=%inifile%`n
  inifile=%inifile%`n[Settings]
  inifile=%inifile%`ncapslockidle=10
  inifile=%inifile%`nshowstatus=1
  inifile=%inifile%`ndelaycapslock=0
  inifile=%inifile%`ndelayf1=0
  inifile=%inifile%`ndelayinsert=0
  inifile=%inifile%`ndelayscrolllock=1
  inifile=%inifile%`ndelaynumlock=1
  inifile=%inifile%`n
  inifile=%inifile%`nae=æ
  inifile=%inifile%`noe=ø
  inifile=%inifile%`naa=å
  inifile=%inifile%`nAE=Æ
  inifile=%inifile%`nOE=Ø
  inifile=%inifile%`nAA=Å
  FileAppend,%inifile%,NumLock.ini
  inifile=
}
IniRead,capslockidle,NumLock.ini,Settings,capslockidle
IniRead,showstatus,NumLock.ini,Settings,showstatus
IniRead,delaycapslock,NumLock.ini,Settings,delaycapslock
IniRead,delayf1,NumLock.ini,Settings,delayf1
IniRead,delayinsert,NumLock.ini,Settings,delayinsert
IniRead,delayscrolllock,NumLock.ini,Settings,delayscrolllock
IniRead,delaynumlock,NumLock.ini,Settings,delaynumlock

If delaycapslock=1
  Hotkey,$CapsLock,DELAY
If delayf1=1
  Hotkey,$F1,DELAY
If delayinsert=1
  Hotkey,$Insert,DELAY
If delaynumlock=1
  Hotkey,$NumLock,DELAY
If delayscrolllock=1
  Hotkey,$ScrollLock,DELAY

swapcount=0
Loop,Read,NumLock.ini
{
  StringLeft,char,A_LoopReadLine,1
  If char=`;
    Continue
  IfInString,A_LoopReadLine,[Settings]
    Continue
  If A_LoopReadLine Contains capslockidle=,showstatus=,delaycapslock=,delayf1=,delayinsert=,delayscrolllock=,delaynumlock=
    Continue
  IfNotInString,A_LoopReadLine,=
    Continue
  swapcount+=1
  StringSplit,swap_%swapcount%_,A_LoopReadLine,=
}
Return
