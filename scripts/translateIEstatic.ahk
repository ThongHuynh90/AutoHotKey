applicationname=Translator
Menu, Tray, Icon, E:\OneDrive - Ho Chi Minh City University of Technology\Hobby\AutoHotKey\icons\Trans.ico


#NoEnv  ;~ Recommended for performance and compatibility with future AutoHotkey releases.
;~ SendMode Input  ;~ Recommended for new scripts due to its superior speed and reliability.
;~ SetWorkingDir %A_ScriptDir%  ;~ Ensures a consistent starting directory.
;~ SetTitleMatchMode, 3
TRAYMENU:
Menu,Tray,NoStandard 
Menu,Tray,DeleteAll 
Menu,Tray,Add,C&onfig,CONFIG
Menu,Tray,Add,E&xit,EXIT
Menu,Tray,Tip,%applicationname%



ToolTipVisible = 0
IE := ComObjCreate("InternetExplorer.Application")
;~ IE.Visible := 1
;~ Interface for selecting source and target language
Gui, 1:Add, Text, x10 y15 vTb1, Source language:
Gui, 1:Add, Combobox, x+20 yp-3 vLangIn, en||no|auto ;~ place double pipe behind language to be used as default
Gui, 1:Add, Text, x10 y+15 vTb2, Target language:
Gui, 1:Add, Combobox, x+22 yp-3 vLangOut, vi||en  ;~ place double pipe behind language to be used as default
Gui, 1:Add, Checkbox, x10 y+20 vPaste2CB, Paste translation to clipoard when closing tooltip
Gui, 1:Add, Checkbox, x10 y+15 Checked vHideToolTip, Hide tooltip on mouseclick
Gui, 1:Add, Button, x30 y+20 w80 vB1, &Exit
Gui, 1:Add, Button, x+30 w80 Default vB2, &OK
Gui, 1:Submit
Return

ButtonExit:
GuiEscape:
GuiClose:
IE.Quit
ExitApp



ButtonOK:
Gui, 1:Submit
Return


;~ [Ctrl]+[F12] shows the little user interface for changing source and target language
CONFIG:
Gui, 1:Show, Autosize
Return

;~ A mouse click makes the tooltip disappear
~RButton::
~MButton::
~LButton::
If HideToolTip = 0
    Return
If ToolTipVisible = 1
{
    ToolTip
    ToolTipVisible = 0
    Return
}
Return

;~ [F12] runs Google Translate for selected text or makes the tooltip with the translation disappear if it is visible
Launch_App2::
If ToolTipVisible = 1
{
    ToolTip
    ToolTipVisible = 0
    Return
}
CurrentCB = %Clipboard%
Clipboard =
SendInput, ^c
ClipWait, 5
If ErrorLevel
{
    MsgBox, 48, GoogleTranslateSelection, No text highlighted or problem copying text to clipboard.
    Return
}
Source = %Clipboard%
StringLen, SourceLength, Source
SourceLength := SourceLength * 5
ToolTip, Translating..., % A_CaretX-SourceLength, % A_CaretY+50
Target =
try
{
Target := GoogleTranslate(Source,LangIn,LangOut,IE)
}
catch e 
{
    MsgBox % "Error in " e.What ", which was called at line " e.Line 
}
ToolTip, %Target%, % A_CaretX-SourceLength, % A_CaretY+50
ToolTipVisible = 1
If Paste2CB = 1
    Clipboard = %Target%
Else
    Clipboard = %CurrentCB%

Return

GoogleTranslate(phrase,LangIn,LangOut,IE)
{
base := "https://translate.google.no/?hl=en&tab=wT#"
path := base . LangIn . "/" . LangOut . "/" . phrase
loopcnt := 0
IE.Navigate(path)
;~ aa := IE.readyState
;~ bb := IE.document.readyState
;~ cc := IE.busy
While IE.readyState!=4 || IE.document.readyState!="complete" || IE.busy
       { 
       Sleep 100
       loopcnt := loopcnt+1
       if loopcnt=10
       break
       }
       ;~ MsgBox %aa% %bb% %cc%    
       Sleep 250
return IE.document.getElementsByClassName("tlid-translation translation")[0].innertext
}

EXIT:
IE.Quit
ExitApp