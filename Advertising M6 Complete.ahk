#Requires AutoHotkey v2.0
OnError LogError
If !A_IsAdmin {
Run '*RunAs "' A_ScriptFullPath '" /restart'
ExitApp
}


titlee := Array(),acc := Array(),accctimer := Array(),timetype := Array(),timetype.Default := "",accctimertype := Array(),newcounter := Array(),PasswordsControls := Array(),counter := Array()  ; Creating Arrays
Accountfilename := "accounts.cfg"
zxc := 1000
phaseActive := false
Loggedin := false
statState1 := "Regular" ; AFK/Regular
statState2 := "Paused" ; Paused/Sending
state := 0
Blocker := 0
Elvuimodevar := 0
InactiveAccIDD := 111111111 ; Something random to assign as idd for inactive accounts
RandomedSleep := 0
reverse := false
LogOpened := ""
MyGui := Gui("-MaximizeBox", statState1 . " " . statState2 . "- XLoVeR")
LoadConfigs()
LoadAccounts()
; Gui Setup Started
MakeGui()
; Gui Setup Finished

; Start Functions
AccLogin() { ; Accounts Login/Location Info
global AccountNO,counterlogin := 1,counter := Array(),accctimertype,InactiveAccIDD,winx,defaultwinx,defaultwiny,winy,zxc
Global titlee := Array(),acc := Array(),accctimer := Array(),timetype := Array(),accctimertype := Array(), Groups := Array()
Groups.Length := AccountNO
Groups.Default := 0
foundingroup := 0
zxc := 1000
	winx := defaultwinx
	winy := defaultwiny
While counterlogin/5 <= AccountNO {
Splittedvar := StrSplit(AccountsInfo.Get(counterlogin+4),"-") ; Intervals
Interval1 := Splittedvar.Get(1) ; Min
Interval2 := Splittedvar.Get(2) ; Max
If Splittedvar.Length < 4 {
Splittedvar.Push(0)
} Else If Splittedvar.Length > 4 {
MsgBox "Accounts File Has a error in Timer Param"
}

ywq := Splittedvar.Get(4) ; Group info
If ywq = 0 { ; Not Grouped
Timerforacc := Round(Random(Interval1,Interval2),-3)
} Else If Groups.Get(ywq) != 0 {  ; Grouped and it has a value
Timerforacc := Groups.Get(ywq)
} Else { ; Grouped but no group value saved
Timerforacc := Round(Random(Interval1,Interval2),-3)
Groups[ywq] := Timerforacc
}

CreateTitle(AccountsInfo.Get(counterlogin),AccountsInfo.Get(counterlogin+1),AccountsInfo.Get(counterlogin+2),AccountsInfo.Get(counterlogin+3),Timerforacc,Splittedvar.Get(3))
counterlogin += 5
}


If titlee.Length != AccountNO {
Loop AccountNO - titlee.Length {
titlee.Push(InactiveAccIDD)
acc.Push(InactiveAccIDD)
accctimertype.Push("")
}
}
counter := accctimer.Clone()
}

LoginnResize(Btn,*) {
MyGui.Opt("+OwnDialogs")
Global phaseActive,Loggedin,titlee,acc,accctimer,timetype,accctimertype,winx,defaultwinx,defaultwiny,winy
winx := defaultwinx
winy := defaultwiny
Global titlee := Array(),acc := Array(),accctimer := Array(),timetype := Array(),accctimertype := Array(),Loggedin := false
		       if phaseActive = true {
			   MsgBox "Pause The Script First"
			   } Else {
Btn.Enabled := false
Mygui["Run WoWs"].Enabled := false
;ELV Mygui["ElvUI Close Button Mode"].Enabled := false
Mygui["Paused"].Enabled := false
Mygui["Reload"].Enabled := false
Mygui["Logout"].Enabled := false

AccLogin()
Loggedin := true
If Elvuimodevar = 0 {
MsgBox "
  (
    All Accounts Logged In.
  )", "Logged in", "OK"
Btn.Text := "Relog"
}  else {
MsgBox "
  (
    All Elvui Close Buttons Clicked.
  )", "Elvui Dialog Closed", "OK"
}
Btn.Enabled := true
;ELV Mygui["ElvUI Close Button Mode"].Enabled := true
Mygui["Run WoWs"].Enabled := true
Mygui["Paused"].Enabled := true
Mygui["Reload"].Enabled := true
Mygui["Logout"].Enabled := true


}
}

MakeGui() {
Global AccountNO,LoginResize,AFKMode,StartPause,BlockAppBtn,BtnEditConfig,BtnEditAccounts,BtnReload,BtnEditElvUI,ElvUIBtn,ElvUImode,BtnExit,RunWoWsBtn,Executetimer,MyGui
If AccountNO < 24 { ; Big Size
MyGui.SetFont("s9","Verdana")
MyGui.Opt("+OwnDialogs")
LoginResize := MyGui.Add("Button","x10 y0 W186 H50", "Login").OnEvent("Click", LoginnResize)
AFKMode := MyGui.Add("Button","x196 y50 W186 H50", "AFK MODE is OFF").OnEvent("Click", ToggleAFKMode)
StartPause := MyGui.Add("Button","x10 y50 W186 H50", "Paused").OnEvent("Click", Togglestate)
LogoutBtn := MyGui.Add("Button","x196 y0 W186 H50", "Logout").OnEvent("Click", LogoutAccounts)
BlockAppBtn := MyGui.Add("Button","x196 y100 W186 H50", "Block Firewall").OnEvent("Click", FirewallCheck)
BtnEditConfig := MyGui.Add("Button","x10 y200 W186 H50", "Config").OnEvent("Click", SettingsGui)
BtnEditAccounts := MyGui.Add("Button","x196 y200 W186 H50", "Accounts").OnEvent("Click", NewEditAccounts)
BtnReload := MyGui.Add("Button","x196 y250 W186 H50", "Reload").OnEvent("Click", ReloadBtn)
;ELV If DirExist(WoWLocation "\Interface\AddOns\ElvUI") {
;ELV BtnEditElvUI := MyGui.Add("Button","x196 y150 W186 H50", "Edit ElvUI").OnEvent("Click", ElvUI)
;ELV ElvUIBtn := MyGui.Add("Button","x10 y100 W186 H50", "Replace Elvui CFG").OnEvent("Click", ReplaceElvuilua)
M6EditBtn := MyGui.Add("Button","x196 y150 W186 H50", "Edit M6 CFG").OnEvent("Click", M6File)
M6Btn := MyGui.Add("Button","x10 y100 W186 H50", "Replace M6 CFG").OnEvent("Click", ReplaceM6lua)
;ELV ElvUImode := MyGui.Add("CheckBox", "x20 y260 W176","ElvUI Close Button Mode").OnEvent("Click",Modechanged)
;ELV }
BtnExit := MyGui.Add("Button"," x196 y300 W186 H50", "Exit").OnEvent("Click", Exitt)
RunWoWsBtn := MyGui.Add("Button","x10 y150 W186 H50", "Run WoWs").OnEvent("Click", RunWoWs)
} Else { ; Compact Mode
MyGui.SetFont("s7","Verdana")
LoginResize := MyGui.Add("Button","x0 y0 W93 H50", "Login").OnEvent("Click", LoginnResize)
LogoutBtn := MyGui.Add("Button","x93 y0 W93 H50", "Logout").OnEvent("Click", LogoutAccounts)
AFKMode := MyGui.Add("Button","x93 y50 W93 H50", "AFK MODE is OFF").OnEvent("Click", ToggleAFKMode)
StartPause := MyGui.Add("Button","x0 y50 W93 H50", "Paused").OnEvent("Click", Togglestate)
BlockAppBtn := MyGui.Add("Button","x93 y150 W93 H50", "Block Firewall").OnEvent("Click", FirewallCheck)
BtnEditConfig := MyGui.Add("Button","x0 y200 W93 H50", "Config").OnEvent("Click", SettingsGui)
BtnEditAccounts := MyGui.Add("Button","x93 y200 W93 H50", "Accounts").OnEvent("Click", NewEditAccounts)
BtnReload := MyGui.Add("Button","x93 y250 W93 H50", "Reload").OnEvent("Click", ReloadBtn)

;ELV If DirExist(WoWLocation "\Interface\AddOns\ElvUI") {
;ELV BtnEditElvUI := MyGui.Add("Button","x93 y100 W93 H50", "Edit ElvUI").OnEvent("Click", ElvUI)
;ELV ElvUIBtn := MyGui.Add("Button","x0 y100 W93 H50", "Replace Elvui CFG").OnEvent("Click", ReplaceElvuilua)
M6EditBtn := MyGui.Add("Button","x93 y100 W93 H50", "Edit M6 CFG").OnEvent("Click", M6File)
M6Btn := MyGui.Add("Button","x0 y100 W93 H50", "Replace M6 CFG").OnEvent("Click", ReplaceM6lua)

;ELV ElvUImode := MyGui.Add("CheckBox", "x5 y260 W85","ElvUI Close Button Mode").OnEvent("Click",Modechanged)
;ELV }
BtnExit := MyGui.Add("Button"," x93 y300 W93 H50", "Exit").OnEvent("Click", Exitt)
RunWoWsBtn := MyGui.Add("Button","x0 y150 W93 H50", "Run WoWs").OnEvent("Click", RunWoWs)
}
Executetimer := MyGui.Add("StatusBar",, "Execute Time:")

CheckFWStatus() ; Check FW Status
MyGui.Show()
MyGui.OnEvent("Close", Exitt)
}

SavetoFile(*) {
MyGui.Opt("+OwnDialogs")
Global MyArray, AccountNO,Accountfilename
If FileExist(Accountfilename) {
FileCopy(Accountfilename,Accountfilename ".backup",1)
FileDelete(Accountfilename)
}
loop AccountNO {
	If A_Index != 1 {
	FileAppend("`r`n",Accountfilename)
	}
    az := A_Index
    startIndex := (az - 1) * 8 + 1
    endIndex := az * 8

    Loop endIndex - startIndex + 1
    {
        currentIndex := startIndex + A_Index - 1  ; current index in the array
		If endindex - currentIndex = 1 { ; Timers part
		FileAppend(MyArray[currentIndex].Text "-",Accountfilename)
		Continue
		} Else If endindex - currentIndex = 2 {
		FileAppend(MyArray[currentIndex].Text "-",Accountfilename)
		continue
		} Else If endindex - currentIndex = 3 {
		FileAppend(MyArray[currentIndex].Text "-",Accountfilename)
		continue
		}
		Else If endindex - currentIndex = 4 {
		If MyArray[currentIndex].Value = 1 {
		FileAppend(0 ",",Accountfilename)
		} Else {
		FileAppend(1 ",",Accountfilename)
		}
		continue
		} Else {
		FileAppend(MyArray[currentIndex].Text ",",Accountfilename)
		continue
		}
    }
}
LoadAccounts(0)
MsgBox "Saved and Applied"

}

Enablemygui(Hwnd) {
MyGui.Opt("-Disabled")

}

NewEditAccounts(Btn := "",*) {
Global NewAccount
NewAccount := Gui("+Owner" MyGui.Hwnd, "Edit Accounts - XLoVeR")
MyGui.Opt("+Disabled")
NewAccount.OnEvent("Close",Enablemygui)
Generate(Btn)
NewAccount.Add("Button","x450 W100 H30","Reload from file").OnEvent("Click",Reloadfile)
NewAccount.Add("Button","x560 yp W50 H30","Save").OnEvent("Click",SavetoFile)
NewAccount.Show()
}

Reloadfile(Btn,*) {
Global NewAccount
NewAccount.Destroy()
NewEditAccounts(Btn)
}

Generate(Btn := "",*) {
Global NewAccount, MyArray,PasswordsControls := Array()
MyArray := Array()
MyArray.Length := AccountsInfo.Length * 2
zxc := AccountNO*5 - AccountsInfo.Length
Loop zxc {
AccountsInfo.Push("")
}
if AccountsInfo.Length = AccountNO*5+1 {
AccountsInfo.Pop()
}
Counterqwe := 1
NewAccount.Add("Text",'x60 y15', "Name")
NewAccount.Add("Text",'x225 y15', "Email")
NewAccount.Add("Text",'x355 y15', "Password")
NewAccount.Add("CheckBox",'x370 y0', "").OnEvent("Click",ShowPasswordFunc)
NewAccount.Add("Text",'x425 y15', "Min")
NewAccount.Add("Text",'x475 y15', "Max")
NewAccount.Add("Text",'x525 y15', "Type")
NewAccount.Add("Text",'x575 y15', "Group")
NewAccount.Add("Text",'x625 y15', "Enabled")

x := 0, y:= 30, i := 1
For value in AccountsInfo {
If i = 6 {
y += 25
x := 0
i := 1
}
If i = 1 { ; Account Title
MyArray[Counterqwe] := NewAccount.Add("Edit", "x" x " y" y " W150 R1" , StrReplace(value,"`r`n",""))
x += 150
i += 1
Counterqwe += 1
continue
} Else if i = 2 { ; Email
MyArray[Counterqwe] := NewAccount.Add("Edit", "x" x " y" y " W200 R1" , value)
x += 200
i += 1
Counterqwe += 1
continue
} Else if i = 3 { ; Password
MyArray[Counterqwe] := NewAccount.Add("Edit", "x" x " y" y " W60 R1 Password*" , value)
MyArray[Counterqwe].Name := "Password" A_Index
PasswordsControls.Push("Password" A_Index)
x += 65
i += 1
Counterqwe += 1
continue
} Else if i = 4 { ; Disable/Enable
If value = 1 {
MyArray[Counterqwe] := NewAccount.Add("CheckBox", "x" x+220 " y" y+4 " R0 W40 -Wrap", "")
} Else {
MyArray[Counterqwe] := NewAccount.Add("CheckBox", "Checked x" x+220 " y" y+4 " R0 W40 Checked", "")
}
Counterqwe += 1
i += 1
continue
} Else if i = 5 { ; Timers/TimeGroup/Group
value := StrSplit(value,"-")
lengthz := value.Length
If lengthz >= 2 {
MyArray[Counterqwe] := NewAccount.Add("Edit", "Number x" x " y" y " W50 R1" , value[1])
Counterqwe += 1
MyArray[Counterqwe] := NewAccount.Add("Edit", "Number x" x+50 " y" y " W50 R1" , value[2])
} Else {
MyArray[Counterqwe] := NewAccount.Add("Edit", "Number x" x " y" y " W50 R1" , "0")
Counterqwe += 1
MyArray[Counterqwe] := NewAccount.Add("Edit", "Number x" x+50 " y" y " W50 R1" , "0")
}
Counterqwe += 1
If lengthz >= 3 {
MyArray[Counterqwe] := NewAccount.Add("Dropdownlist", "x" x+100 " y" y " W50" , ['','/2','/3','/3*2'])
MyArray[Counterqwe].Text := value[3]
} Else {
MyArray[Counterqwe] := NewAccount.Add("Dropdownlist", "x" x+100 " y" y " W50" , ['','/2','/3','/3*2'])
}
Counterqwe += 1
If lengthz >= 4 {
MyArray[Counterqwe] := NewAccount.Add("Edit", "Number x" x+150 " y" y " W50 R1" , value[4])
} Else {
MyArray[Counterqwe] := NewAccount.Add("Edit", "x" x+150 " y" y " W50 R1" , "0")
}
Counterqwe += 1
i += 1
continue
}
}
}

SettingsGui(*) {
Global winx,winy,winsizex,winsizey,defaultpassword,MacroButtons,MacroAFKButtons,WoWLocation,AccountNO,pixelloginx,pixelloginy,pixelcolorlogin,elvuipixelx,elvuipixely,elvuipixelcolor1,elvuipixelcolor2,offsetx,offsety,defaultwiny,xbuttonsgetdef,defaultwinx,iniFile,Settingsarray,reverse,Settingsui,ShowPasswordSettings
Settingsui := Gui("+Owner" MyGui.Hwnd, "Settings - XLoVeR")
MyGui.Opt("+Disabled")
Settingsarray := Array()
Settingsarray.Length := 20
Settingsui.Add("GroupBox", "w200 h140", "Sorting")
Settingsui.Add("Text","x20 y30 W100 H20","Starting position X :")
Settingsui.Add("Text","x20 y60 W100 H20","Starting position Y :")
Settingsui.Add("Text","x20 y90 W100 H20","Window Size X :")
Settingsui.Add("Text","x20 y120 W100 H20","Window Size Y :")

Settingsarray[1] := Settingsui.Add("Edit","x140 y25 W65 R1",winx)
Settingsarray[2] := Settingsui.Add("Edit","x140 y55 W65 R1",winy)
Settingsarray[3] := Settingsui.Add("Edit","x140 y85 W65 R1",winsizex)
Settingsarray[4] := Settingsui.Add("Edit","x140 y115 W65 R1",winsizey)

Settingsui.Add("GroupBox", "x220 y5 w330 h170", "Settings")
Settingsui.Add("Text","x240 y30 W100 H20","Default password :")
Settingsui.Add("Text","x240 y60 W100 H20","MacroButtons :")
Settingsui.Add("Text","x240 y90 W100 H20","AFK Mode Buttons :")
Settingsui.Add("Text","x240 y120 W120 H20","WoW Folder Location :")
Settingsui.Add("Text","x240 y150 W100 H15","Accounts No. :")

Settingsarray[5] := Settingsui.Add("Edit","x360 y25 W150 R1 Password*",Defaultpassword)
ShowPasswordSettings := Settingsui.Add("Checkbox","x520 y30 W25","").OnEvent("Click",ShowPasswordFunc)
Settingsarray[6] := Settingsui.Add("Edit","x360 y55 W150 R1",MacroButtons)
Settingsarray[7] := Settingsui.Add("Edit","x360 y85 W150 R1",MacroAFKButtons)
Settingsarray[8] := Settingsui.Add("Edit","x360 y115 W80 R1",WoWLocation)
Settingsui.Add("Button","x440 y115","Select Folder").OnEvent("Click",FolderSelect)
Settingsarray[9] := Settingsui.Add("Edit","x360 y145 Number W30",AccountNO)

Settingsui.Add("GroupBox", "x5 y175 w300 h130", "LoginScreen")
Settingsui.Add("Text","x20 y195 W100 H20","Login Static Pixel X :")
Settingsui.Add("Text","x20 y225 W100 H20","Login Static Pixel Y :")
Settingsui.Add("Text","x20 y255 W100 H20","Static Pixel Color :")
Settingsui.Add("Text","x20 y285 W120 H20","Remember Account:")

Settingsarray[10] := Settingsui.Add("Edit","x150 y195 Number W30 R1",pixelloginx)
Settingsarray[11] := Settingsui.Add("Edit","x150 y225 Number W30 R1",pixelloginy)
Settingsarray[12] := Settingsui.Add("Edit","x150 y255 W65 R1",pixelcolorlogin)
If reverse = 0 {
Settingsarray[13] := Settingsui.Add("CheckBox","Checked x150 y285 W20 R1")
} Else {
Settingsarray[13] := Settingsui.Add("CheckBox","x150 y285 W20 R1")
}

;ELV Settingsui.Add("GroupBox", "x5 y315 w300 h130", "ElvUI")
;ELV Settingsui.Add("Text","x20 y335 W100 H15","Elvui Static Pixel X:")
;ELV Settingsui.Add("Text","x20 y365 W100 H15","Elvui Static Pixel Y:")
;ELV Settingsui.Add("Text","x20 y395 W120 H15","Elvui Pixel Color:")
;ELV Settingsui.Add("Text","x20 y425 W130 H15","Elvui Hovered Pixel Color:")


;ELV Settingsarray[14] := Settingsui.Add("Edit","x150 y330 Number W30",elvuipixelx)
;ELV Settingsarray[15] := Settingsui.Add("Edit","x150 y360 Number W30",elvuipixely)
;ELV Settingsarray[16] := Settingsui.Add("Edit","x150 y390 W65 R1",elvuipixelcolor1)
;ELV Settingsarray[17] := Settingsui.Add("Edit","x150 y420 W65 R1",elvuipixelcolor2)

Settingsui.Add("Button", "x345 y200 w90 h50", "Save/Apply").OnEvent("Click",SaveToConfig)
Settingsui.Add("Button", "x345 y250 w90 h50", "Close").OnEvent("Click",CloseSettings)
Settingsui.OnEvent("Close",CloseSettings)
Settingsui.Show()

}

ShowPasswordFunc(Btn,*) {
Global Settingsarray,Settingsui,ShowPasswordSettings,MyArray,AccountNO,PasswordsControls

If InStr(Btn.Gui.Title,"Settings") {
If Btn.Value = 1 {
Settingsarray[5].Opt("-Password*")
} Else {
Settingsarray[5].Opt("+Password*")
}
} Else If InStr(Btn.Gui.Title,"Accounts") {
If Btn.Value = 1 {
Loop PasswordsControls.Length {
NewAccount[PasswordsControls[A_Index]].Opt("-Password*")
}
} Else {
Loop PasswordsControls.Length {
NewAccount[PasswordsControls[A_Index]].Opt("+Password*")
}
}
}
}

CloseSettings(*) {
Global Settingsui
MyGui.Opt("-Disabled")
Settingsui.Destroy()
}

SaveToConfig(*) {
Global Settingsarray,iniFile
If FileExist(iniFile) {
FileCopy(iniFile,iniFile ".backup",1)
FileDelete(iniFile)
}
IniWrite Settingsarray[1].Text, iniFile, "Sorting", "winx"
IniWrite Settingsarray[2].Text, iniFile, "Sorting", "winy"
IniWrite Settingsarray[3].Text, iniFile, "Sorting", "winsizex"
IniWrite Settingsarray[4].Text, iniFile, "Sorting", "winsizey"
IniWrite Settingsarray[5].Text, iniFile, "Settings", "Defaultpassword"
IniWrite Settingsarray[6].Text, iniFile, "Settings", "MacroButtons"
IniWrite Settingsarray[7].Text, iniFile, "Settings", "MacroAFKButtons"
IniWrite Settingsarray[8].Text, iniFile, "Settings", "WoWLocation"
IniWrite Settingsarray[9].Text, iniFile, "Settings", "AccountNO"
IniWrite Settingsarray[10].Text, iniFile, "LoginScreen", "pixelloginx"
IniWrite Settingsarray[11].Text, iniFile, "LoginScreen", "pixelloginy"
IniWrite Settingsarray[12].Text, iniFile, "LoginScreen", "pixelcolorlogin"
If Settingsarray[13].Value = 1 {
IniWrite 0, iniFile, "LoginScreen", "reverse"
} Else {
IniWrite 1, iniFile, "LoginScreen", "reverse"
}
;ELV IniWrite Settingsarray[14].Text, iniFile, "Elvui", "elvuipixelx"
;ELV IniWrite Settingsarray[15].Text, iniFile, "Elvui", "elvuipixely"
;ELV IniWrite Settingsarray[16].Text, iniFile, "Elvui", "elvuipixelcolor1"
;ELV IniWrite Settingsarray[17].Text, iniFile, "Elvui", "elvuipixelcolor2"
LoadConfigs(0)
MsgBox "Saved and Applied Settings"
}

FolderSelect(*) {
Settingsui.Opt("+OwnDialogs")
Global WoWLocation,Settingsarray
SelectedFile := FileSelect("D", WoWLocation, "Select _retail_ Folder","")
if SelectedFile = "" {
    Settingsarray[8].Value := WoWLocation
} else {
If SubStr(SelectedFile,-1,1) = "\" {
SelectedFile := RTrim(SelectedFile,"\")
}
If SubStr(SelectedFile,-8,8) != "_retail_" {
MsgBox "Select _retail_ Folder!"
} Else {
Settingsarray[8].Value := SelectedFile
}
}
}

LogoutAccounts(*) {
MyGui.Opt("+OwnDialogs")
Global InactiveAccIDD,Acc
Result := MsgBox( "Are you sure you want to Logout All WoW Tabs?","Logout Command",4)
If Result = "Yes" {
For value in Acc {
If WinExist(value) And WinActive(value) = 0 And value != InactiveAccIDD
{
ControlSend("{ENTER}",value) ; 186, 187
Sleep 300
ControlSend('/logout',value)
Sleep 100
ControlSend('{ENTER}',value)

}
}
MsgBox "All Accounts Logged out"
}
}

ElvUI(*) {
Run WoWLocation "\WTF\ElvUI.lua"
}

M6File(*) {
Run WoWLocation "\WTF\M6.lua"
}
ConsoleWrite(Text) {
Debugfile := A_ScriptDir "\Logs\debug.log"
Try {
Stdout := FileAppend(FormatTime("R") " - " Text "`n","*") ; Stdout if Available
} Catch {
DirCreate "Logs"
FileAppend FormatTime("R") " - " Text "`n",Debugfile
}
}

LogError(exception, mode) {
ConsoleWrite("Error on line " exception.Line ": " exception.Message "`n")
MsgBox "Error Exiting Program..."
    ExitApp
}

ReloadBtn(Btn,*) {
LoadAccounts(Btn)
LoadConfigs(Btn)
}

LoadAccounts(Btn := 0,*) {
MyGui.Opt("+OwnDialogs")
Global AccountsFile, AccountsInfo, AccountNO, Countthem := "",Accountfilename
If FileExist(Accountfilename) {
AccountsFile := Fileread(Accountfilename)
}
Else {
FileAppend("",Accountfilename)
AccountsFile := Fileread(Accountfilename)
}
AccountsInfo := StrSplit(AccountsFile,",")
If AccountsInfo.Length < AccountNO*5 {
If SubStr(AccountsFile,-2) = "`r`n" {

Loop AccountNO+1-AccountsInfo.Length/5 {
FileAppend(",,,,,`r`n",Accountfilename)
}
LoadAccounts()
} Else {
If AccountsFile != "" {
ConsoleWrite('AccountsFile != ""')
FileAppend("`r`n",Accountfilename)
}
Loop AccountNO-AccountsInfo.Length/5 {
FileAppend(",,,,,`r`n",Accountfilename)
}
LoadAccounts()
}

; FileAppend(",,,,,`r`n",Accountfilename)
}
}

LoadConfigs(Btn := 0,*) {
MyGui.Opt("+OwnDialogs")
Global winx,winy,winsizex,winsizey,defaultpassword,MacroButtons,MacroAFKButtons,WoWLocation,AccountNO,pixelloginx,pixelloginy,pixelcolorlogin,elvuipixelx,elvuipixely,elvuipixelcolor1,elvuipixelcolor2,offsetx,offsety,defaultwiny,xbuttonsgetdef,defaultwinx,iniFile,reverse
iniFile := "config.ini"
winx := IniRead(iniFile, "Sorting", "winx", "0")
winy := IniRead(iniFile, "Sorting", "winy", "0")
winsizex := IniRead(iniFile, "Sorting", "winsizex", "390")
winsizey := IniRead(iniFile, "Sorting", "winsizey", "350")
defaultpassword := IniRead(iniFile, "Settings", "Defaultpassword")
MacroButtons := IniRead(iniFile, "Settings", "MacroButtons", "5")
MacroAFKButtons := IniRead(iniFile, "Settings", "MacroAFKButtons", "{ENTER}{ENTER}")
WoWLocation := IniRead(iniFile, "Settings", "WoWLocation", "C:\World of Warcraft\_retail_")
AccountNO := IniRead(iniFile, "Settings", "AccountNO", "24")
pixelloginx := IniRead(iniFile, "LoginScreen", "pixelloginx", "49")
pixelloginy := IniRead(iniFile, "LoginScreen", "pixelloginy", "29")
pixelcolorlogin := IniRead(iniFile, "LoginScreen", "pixelcolorlogin", "0x6D0C04")
reverse := IniRead(iniFile, "LoginScreen", "reverse", 0)
elvuipixelx := IniRead(iniFile, "Elvui", "elvuipixelx", "255")
elvuipixely := IniRead(iniFile, "Elvui", "elvuipixely", "106")
elvuipixelcolor1 := IniRead(iniFile, "Elvui", "elvuipixelcolor1", "0x000000")
elvuipixelcolor2 := IniRead(iniFile, "Elvui", "elvuipixelcolor2", "0xE6E6E6")
offsetx := winsizex+1
offsety := winsizey
defaultwiny := winy
defaultwinx := winx
xbuttonsgetdef := MacroButtons
If Btn != 0 {
MsgBox "Reloaded Configs"

}
}

CheckFWStatus() {
Global Blocker,Mygui
ruleName := "World of Warcraft"
command := 'cmd.exe /c netsh advfirewall firewall show rule name="World of Warcraft" > C:\temp_output.txt'
OutputVar := "C:\temp_output.txt"
; Execute the command and redirect output to a file
RunWait command, "", "Hide"

; Read the content of the output file

; Check if the output contains the rule name
if FileExist("C:\temp_output.txt") {
sss := FileRead("C:\temp_output.txt")

if InStr(sss, ruleName) {
    Blocker := 1
} else {
    Blocker := 0
}
; Clean up the temporary file
FileDelete ("C:\temp_output.txt")
}
}

Clicker(x,y,Hwnd) {
LP := (y << 16) | (x & 0xffff)
PostMessage 0x0200 , 0x00000000 ,LP,,Hwnd	;MOUSEMOVE POST
SendMessage 0x0020 , 0x00040708 ,0x02040001,,Hwnd	;SETCURSOR SEND
PostMessage 0x0201 , 0x00000002 ,LP,,Hwnd	;LBUTTONDOWN POST
SendMessage 0x0020 , 0x00040708 ,0x02050001,,Hwnd	;SETCURSOR SEND
PostMessage 0x0202 , 0x00000000 ,LP,,Hwnd	;LBUTTONUP POST
}

CreateTitle(name, user, pass := defaultpassword, disabledor := 0,Timerforacc := Round(Random(15000,17000),-3),timeType := "") {
    Global titlee, winx, winy, acc, defaultwiny, offsety, offsetx, accctimer, accctimertype, InactiveAccIDD, defaultwinx, AccountNO
	accctimertype.Push(timeType)
    titlee.Push(StrReplace(name,"`r`n"))  ; Use Push to add the title
	If disabledor == 0 {
    acc.Push(getid(titlee[titlee.Length])) ; Access the last item with Length
    titles(acc[acc.Length], titlee[titlee.Length], winx, winy, user, pass)
	accctimer.Push(Timerforacc) ; 15000-17000
	} Else {
	acc.Push(InactiveAccIDD)
	titlee.Push(InactiveAccIDD)
	accctimer.Push(Timerforacc) ; 15000-17000
	}
    winy += offsety
    ; Update condition to reset winy based on a suitable threshold
    If (winy = defaultwiny + (offsety * 4)) {
        winy := defaultwiny
		if AccountNO != acc.Length {
        winx += offsetx
		} Else {
		winx := defaultwinx
		}
    }
}
ReplaceM6lua(*) {
MyGui.Opt("+OwnDialogs")
RunWait 'replace "' . WoWLocation . '\WTF\M6.lua" "' . WoWLocation . '\WTF\Account\" /s',,"Hide"
MsgBox "Replaced M6 Configs"
}
ReplaceElvuilua(*) {
MyGui.Opt("+OwnDialogs")
RunWait 'replace "' . WoWLocation . '\WTF\Elvui.lua" "' . WoWLocation . '\WTF\Account\" /s',,"Hide"
MsgBox "Replaced Elvui Configs"
}

RunWoWs(Btn,*) {
MyGui.Opt("+OwnDialogs")
Global WoWLocation, AccountNO
Result := MsgBox( "Are you sure you want to run " . AccountNO . " WoW Tabs?","Run WoW Tabs",4)
If Result = "Yes" {
Loop AccountNO {
Run WoWLocation  . "\WoW.exe"
WinWait "World of Warcraft"
WinSetTitle "WooooW","World of Warcraft"
}
MsgBox "Done."
}
}

Modechanged(Btn,*) {
Global Elvuimodevar
if Btn.Value = 1 {
Try {
Mygui["Login"].Text := "ElvUI Close Button"
}
Catch {
Mygui["Relog"].Text := "ElvUI Close Button"
}
Elvuimodevar := 1
}
Else {
If Loggedin = false {
Mygui["ElvUI Close Button"].Text := "Login"
} Else {
Mygui["ElvUI Close Button"].Text := "Relog"
}
Elvuimodevar := 0
}
}

ToggleAFKMode(Btn, *) {
Global MacroButtons, MyGui, xbuttonsgetdef,statState1,statState2,MacroAFKButtons,CLzxc,CLcounter,CLaccctimer,accctimer,counter,zxc
If MacroButtons == xbuttonsgetdef {
MacroButtons := MacroAFKButtons
Btn.Text := "AFK MODE is ON"
statState1 := "AFK"
MyGui.Title := statState1 . " " .  statState2 . " -  XLoVeR"
CLaccctimer := accctimer.Clone()
CLcounter := counter.Clone()
CLzxc := zxc
For index in accctimer {
accctimer[A_Index] := Round(Random(60000,120000),-3)
}
} Else {
accctimer := CLaccctimer.Clone()
counter := CLcounter.Clone()
zxc := CLzxc
MacroButtons := xbuttonsgetdef
Btn.Text := "AFK MODE is OFF"
statState1 := "Regular"
MyGui.Title := statState1 . " " .  statState2 . " -  XLoVeR"
}

}

Exitt(*) {
MyGui.Opt("+OwnDialogs")
Result := MsgBox( "Do you want to Close the Script?","Exit",4)
If Result = "Yes" {
ExitApp()
}
Return true
}

getid(title) {
var := WinExist(title)
If var = 0 {
id := WinExist("WooooW")
if id = 0 {
id := WinExist("World of Warcraft")
}
Return id
}
If var != 0
{
Return var
}

}

titles(iddd , title,xxxx ,yyyy,user,pass := defaultpassword) {
Global Elvuimodevar,winsizex,winsizey,pixelcolorlogin,elvuipixelx,elvuipixelcolor2,elvuipixelcolor1,reverse,pixelloginy,pixelloginx
If WinExist(iddd)
{
WinMove xxxx , yyyy ,winsizex,winsizey,iddd
WinSetTitle title,iddd
Sleep(100)
If Elvuimodevar == 0 {
pixel := RunWait('Pixelcheck.exe "' title '" ' pixelloginx " " pixelloginy) ; Returns Color in Decimal if matches
pixel := Format("{:#x}",pixel)
; WinActivate(iddd)
; WinWaitActive(iddd)
; pixel := PixelGetColor(pixelloginx,pixelloginy)
If pixel = pixelcolorlogin {
If reverse = 0 {
ControlSendText pass ,iddd
Sleep(200)
ControlSend "{TAB}" ,iddd
Sleep(200)
ControlSendText user ,iddd
Sleep(200)
ControlSend "{ENTER}" ,iddd
} Else {
ControlSendText user ,iddd
Sleep(200)
ControlSend "{TAB}" ,iddd
Sleep(200)
ControlSendText pass ,iddd
Sleep(200)
ControlSend "{ENTER}" ,iddd
}
}
} Else {
; WinActivate(iddd)
; WinWaitActive(iddd)
; pixel := PixelGetColor(elvuipixelx,elvuipixely)
pixel := RunWait('Pixelcheck.exe "' title '" ' elvuipixelx " " elvuipixely) ; Returns Color if matches
pixel := Format("{:#x}",pixel)
If pixel = elvuipixelcolor1 or pixel = elvuipixelcolor2 {
Clicker(elvuipixelx,elvuipixely,iddd)
}
}

}
Return
}

trigger(idd) {
If WinExist(idd) And WinActive(idd) = 0 And idd != InactiveAccIDD
{
; ControlSend MacroButtons,idd
If MacroButtons != MacroAFKButtons {
SendKeys(MacroButtons,idd)
} Else {
ControlSend MacroAFKButtons,idd
}
}
}

SendKeys(keys,Hwndg,delay := 5) {
    keys := StrSplit(keys,",")
	keys2 := Array()
    for key in keys {
		For z in StrSplit(key) {
		Keys2.Push(z)
		}
		}
    for key in keys2 {
            ControlSendKeys(GetKeyVK(key), Hwndg)
        }
}

ControlSendKeys(key, Hwnds) {
    PostMessage 0x0100, key, 0x001C0001,, Hwnds ; WM_KEYDOWN
    PostMessage 0x0101, key, 0xC01C0001,, Hwnds ; WM_KEYUP
	Sleep 100
}

Togglestate(Btn,*) {
MyGui.Opt("+OwnDialogs")
    Global state, MyGui, phaseActive,statState1,statState2,Loggedin,LoginResize,Elvuimodevar
    if (state = 0) {
		If Loggedin = false {
		MsgBox "Login First to Start the App"
		} Else {
        phaseActive := true  ; Set the phase to active
        Btn.Text := "Started/Working"
		statState2 := "Sending"
		MyGui.Title := statState1 . " " .  statState2 . "-  XLoVeR Script"
		Try {
		Mygui["Relog"].Enabled := false
		}
		Catch {
		Mygui["ElvUI Close Button"].Enabled := false
		}
		Mygui["Logout"].Enabled := false
		Mygui["Run WoWs"].Enabled := false
		Mygui["Reload"].Enabled := false

        state := 1
        SetTimer WorkingPhaseTimer, 1000  ; Call WorkingPhaseTimer every second
		}
    } else {
        phaseActive := false  ; Stop the phase
        Btn.Text := "Paused"
		statState2 := "Paused"
		MyGui.Title := statState1 . " " .  statState2 . "-  XLoVeR Script"
		Try {
		Mygui["Relog"].Enabled := true
		} Catch {
		Mygui["ElvUI Close Button"].Enabled := true
		}
		Mygui["Logout"].Enabled := true
		Mygui["Run WoWs"].Enabled := true
		Mygui["Reload"].Enabled := true
        SetTimer WorkingPhaseTimer, 0  ; Stop the timer
        state := 0
    }
}

WorkingPhaseTimer() {
Global RandomedSleep,Infunc
StartTime := A_TickCount
WorkingPhase()
Executetime := A_TickCount - StartTime
Executetimer.Text := ("Execute Time: " . Executetime . "ms")
}

FirewallCheck(Btn,*) { ; Toggle Button Firewall Blocker
Global Blocker,Mygui
If Blocker == 0 {
BlockApp(Btn)
} Else {
UnblockApp(Btn)

}
}

BlockApp(Btn) { ; Enable Firewall Blocker
Result := MsgBox( "Are you sure you want to Disconnect All WoW Tabs?","FireWall Block",4)
If Result = "Yes" {
Run A_WorkingDir . '/Fab/fab_x64.exe /A ' . WoWLocation . '\Wow.exe'
MsgBox "Kill Switch Implented."
Sleep 250
Global Blocker := 1
Btn.Text := "UnBlock Firewall"
}
}

UnblockApp(Btn) { ; Disable Firewall Blocker

Run A_WorkingDir . '/Fab/fab_x64.exe /D ' . WoWLocation . '\Wow.exe'
MsgBox "Kill Switch Removed."
Btn.Text := "Block Firewall"
Global Blocker := 0
}

WorkingPhase() { ;Timers
    global accctimer,accctimertype,counter,phaseActive,acc,zxc,counterlogin := 1,RandomedSleep
		       if (!phaseActive)
        return  ; Exit if the phase is not active
Thread "interrupt", 1
		RandomedSleep := Random(10,180)
Sleep RandomedSleep
Loop accctimer.Length {
If accctimertype[A_Index] == "" {
If counter[A_Index] == zxc {
trigger(acc[A_Index])
; ConsoleWrite(zxc ' ' A_Index '/' accctimertype[A_Index])
}
}
If accctimertype[A_Index] == "/2" {
If counter[A_Index] - Round(accctimer[A_Index]/2,-3) == zxc {
trigger(acc[A_Index])
; ConsoleWrite(zxc ' ' A_Index '/' accctimertype[A_Index])
}
}
If accctimertype[A_Index] == "/3" {
If counter[A_Index] - Round(accctimer[A_Index]/3,-3) == zxc {
trigger(acc[A_Index])
; ConsoleWrite(zxc ' ' A_Index '/' accctimertype[A_Index])
}
}
If accctimertype[A_Index] == "/3*2" {
If counter[A_Index] - Round((accctimer[A_Index]/3)*2,-3) == zxc {
trigger(acc[A_Index])
; ConsoleWrite(zxc ' ' A_Index '/' accctimertype[A_Index])
}
}
If counter[A_Index] = zxc {
counter[A_Index] := zxc + accctimer[A_Index]
}
}
zxc := zxc + 1000
Thread "interrupt", 0
}
; End Functions
