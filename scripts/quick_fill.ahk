applicationname=AutoFill
Menu, Tray, Icon, E:\OneDrive - Ho Chi Minh City University of Technology\Hobby\AutoHotKey\icons\Pass.png
Menu,Tray,NoStandard 
Menu,Tray,DeleteAll 
Menu,Tray,Add,AutoFill,ABOUT
Menu,Tray,Add,E&xit,EXIT
Menu,Tray,Tip,%applicationname%

; Create another menu destined to become a submenu of the above menu.
Menu, MailList, Add, htt990@gmail.com, MenuHandler
Menu, MailList, Add, Thong.Huynh@usn.no, MenuHandler
Menu, MailList, Add, 50702365@stu.hcmut.edu.vn, MenuHandler
Menu, MailList, Add, htt_990@yahoo.com, MenuHandler
Menu, MailList, Add, hydr6zug7@abcda.tech, MenuHandler


Menu, PassList, Add, Cb90, Cb90
Menu, PassList, Add, Cu*@p90, Cb@90
Menu, PassList, Add, An*tt, ansa
Menu, PassList, Add, cb, cb
Menu, PassList, Add, cb90t, cub90t
Menu, PassList, Add, jk, jk


; Create a submenu in the first menu (a right-arrow indicator). When the user selects it, the second menu is displayed.
Menu, MyMenu, Add, Mail, :MailList
Menu, MyMenu, Add, Pass, :PassList


return  ; End of script's auto-execute section.

EXIT:
ExitApp
MenuHandler:
Send %A_ThisMenuItem%
return

Cb90:
Send, Cuibap90
return
Cb@90:
Send, Cuib@p90
return
cub90t:
Send, cuibap90
return
cb:
Send, cuibap
return
ansa:
Send, Ansatt567
return
jk:
Send, jackythanhlong
return
#z::Menu, MyMenu, Show  ; i.e. press the Win-Z hotkey to show the menu.



ABOUT:
MsgBox, Press Windows+Z
Return
