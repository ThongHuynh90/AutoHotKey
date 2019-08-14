ie := ComObjCreate("InternetExplorer.Application")
ie.Navigate("www.timeanddate.com")
While (ie.busy || or ie.Readystate <> 4)
	Sleep 100

netTime := ie.Document.getElementbyId("clk_hm").innertext
RunWait, %comspec% /c time %netTime%.%A_Sec%,, Hide
msgbox % ie.Document.getElementbyId("clk_hm").innertext