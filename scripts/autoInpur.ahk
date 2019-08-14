^F1::
Send ^c
WinActivate, iMenuPro - Sample Menu - Google Chrome
MouseClick, left, 400,317 ;use window coordinate
Sleep, 200
Send ^v
Sleep, 200
MouseClick, left, 803,813
Sleep, 200
MouseClick, left, 1200,810
Sleep, 200
return

^F2::
WinActivate, New Tab - Google Chrome
MouseClick, left, 800,517 ;use window coordinate
Send toi la mot{Enter}
return
