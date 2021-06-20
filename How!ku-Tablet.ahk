; search for #=# to find keywords in this looooooong looooooong script
#NoEnv
SetKeyDelay, 0, 50
#SingleInstance force
#NoEnv
SetWorkingDir %A_ScriptDir%
#Persistent
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
#installKeybdHook
#UseHook On
ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 10
SetWinDelay, -1
SetControlDelay, -1
SendMode Input	
DetectHiddenWindows, On
SetTitleMatchMode,2
tooleytipe("How!ku Tablet",2000)
Menu, Tray, Add, CMD, cmd 
;#########################################################################################################################################################################################
;#########################################################################################################################################################################################
;#########################################################################################################################################################################################
;#########################################################################################################################################################################################
;#########################################################################################################################################################################################
;#########################################################################################################################################################################################
;#########################################################################################################################################################################################
;#########################################################################################################################################################################################
;#########################################################################################################################################################################################
;#########################################################################################################################################################################################
;#########################################################################################################################################################################################
;#########################################################################################################################################################################################
;#########################################################################################################################################################################################
;############################################=###############################################################################################################################################
;traytip
tooleytipe(msg, timer = 0){
    Gui Destroy
    Gui, -Caption 
    Gui, Color, c202020
    Gui, +ToolWindow
    Gui, Font, cA878DD
    Gui, Add, text,, %msg%
	Gui, +AlwaysOnTop +Owner
    Gui, Show, NoActivate y0 NA
	if (timer != 0){
		SetTimer, RemoveToolTip, %timer%
		return
		RemoveToolTip:
		Gui, hide
        Gui Destroy
		return
	}
}

HideTrayTip() {
    TrayTip  ; Attempt to hide it the normal way.
    if SubStr(A_OSVersion,1,3) = "10." {
        Menu Tray, NoIcon
        Sleep 200  ; It may be necessary to adjust this sleep.
        Menu Tray, Icon
    }
}
;#########################################################################################################################################################################################
;###########################=################################################################################################################################################################
;Script-addons/Tablet-driver.ahk ctl-4100 small




howku(mode)
{
	ControlSend,, {text}include  profiles/select/%mode%.cfg , Tabletdriver
	ControlSend,, {enter}, Tabletdriver
	FileAppend,, %InDir%save\%mode%.howku
	return
}


Process, Exist,  TabletDriverService.exe
If (ErrorLevel = 0)
{
    If (A_IsAdmin)       ;- I'm 'admin' so it works
    {
	    Run, *RunAs %comspec% /k "Title Tabletdriver" ,,hide,Tabletdriver
    }
    else{
        msgbox,Go back i want to be monke (run it as admin) 
        exitapp
    }

	WinWait, Tabletdriver
	ControlSend,, {text}RunServiceOnly.bat, Tabletdriver
	ControlSend,, {enter}, Tabletdriver
	sleep, 50
	if FileExist("save\big.howku")
	{
		ControlSend,, {text}include  profiles/select/big.cfg, Tabletdriver
		ControlSend,, {enter}, Tabletdriver
	}
	if FileExist("save\small.howku")
	{
		ControlSend,, {text}include profiles/select/small.cfg, Tabletdriver
		ControlSend,, {enter}, Tabletdriver
	}
}


;tabletprofiles###########=##############
^!f16::
KeyWait, ctrl
Keywait, Alt
WinGet, Active_ID, ID, A
WinGet, NewTitle, ProcessName, ahk_id %Active_ID%
clipboard := NewTitle
tooleytipe("Copied "NewTitle,1000)
return


^!+f16::
KeyWait, Ctrl
Keywait, Alt
Keywait, Shift
WinGet, Active_ID, ID, A
WinGet, NewTitle, ProcessName, ahk_id %Active_ID%
MsgBox, 4,,Make a Tablet-profile for "%NewTitle%"?, 5
IfMsgBox, No
    Return  ; User pressed the "No" button.
IfMsgBox, Timeout
    Return ;

if fileExist("profiles\" NewTitle ".cfg")
{
	FileDelete, profiles\%NewTitle%.cfg
}

if fileExist("save\relative.howku")
{
	FileAppend, Include "profiles/select/relative.cfg"`n, %A_WorkingDir%\profiles\%NewTitle%.cfg
}
if fileExist("save\absolute.howku")
{
	FileAppend, Include "profiles/select/absolute.cfg"`n, %A_WorkingDir%\profiles\%NewTitle%.cfg
}
if fileExist("save\Digitizer.howku")
{
	FileAppend, Include "profiles/select/Digitizer.cfg"`n, %A_WorkingDir%\profiles\%NewTitle%.cfg
}


if FileExist("save\small.howku")
{
	FileAppend, Include "profiles/select/small.cfg", %A_WorkingDir%\profiles\%NewTitle%.cfg
}
if FileExist("save\big.howku")
{
	FileAppend, Include "profiles/select/big.cfg", %A_WorkingDir%\profiles\%NewTitle%.cfg
}
TrayTip,, Saved %NewTitle% profile
return


^f15::
KeyWait, Ctrl
WinGet, Active_ID, ID, A
WinGet, NewTitle, ProcessName, ahk_id %Active_ID%
fileexits = profiles\%NewTitle%.cfg
if FileExist(fileexits)
{
	tooleytipe(NewTitle " profile",1000)
	ControlSend,, {text}include profiles/%NewTitle%.cfg, Tabletdriver
	ControlSend,, {enter}, Tabletdriver
	return
}
Else
{
	tooleytipe("Default profile",1000)
	ControlSend,, {text}include  profiles/default.cfg, Tabletdriver
	ControlSend,, {enter}, Tabletdriver
	return
}



^!f15::
WinGetPos X, Y, W, H, A
ControlSend,,{text} screenArea  %W% %H% %X% %Y%, Tabletdriver
ControlSend,, {enter}, Tabletdriver
tooleytipe("WindowArea Mode",1000)
return

+!f15::
ControlSend,, {text}screenArea  2400 1350 0 0 , Tabletdriver
ControlSend,, {enter}, Tabletdriver
tooleytipe("ScreenArea Mode",1000)
return

;#########################=#########






^f17::
KeyWait, Ctrl
if FileExist("save\Relative.howku")
{
	FileDelete, save\Relative.howku
	howku("absolute")
	tooleytipe("absolute-Tablet mode",1000)
	return
}
if FileExist("save\absolute.howku")
{
	FileDelete, save\absolute.howku
	howku("digitizer")
	tooleytipe("Digitizer-Tablet mode",1000)
	return
}
if FileExist("save\Digitizer.howku")
{
	FileDelete, save\Digitizer.howku
	howku("relative")
	tooleytipe("Relative-Tablet mode",1000)
	return
}
Else
{
	
	howku("absolute")
	return
}

^!f17::
KeyWait, Ctrl
Keywait, Alt
if FileExist("save\small.howku")
{
	FileDelete, save\small.howku
	howku("big")
	tooleytipe("big-Tablet size",1000)
	return
}
if FileExist("save\big.howku")
{
	FileDelete, save\big.howku
	howku("small")
	tooleytipe("small-Tablet size",1000)
	return
}
Else
{
	howku("big")
	return
}


^!+f17::
KeyWait, Ctrl
KeyWait, Alt
KeyWait, Shift
MsgBox, 4,,Switch Tablet-rotation?,5
IfMsgBox, No
    Return  
IfMsgBox, Timeout
    Return 

if FileExist("save\upsidedown-view.howku")
{
	FileDelete, %A_WorkingDir%\save\upsidedown-view.howku
	FileDelete, %A_WorkingDir%\config\usersettings.cfg
	FileDelete, %A_WorkingDir%\profiles\select\small.cfg

	FileAppend,, %A_WorkingDir%\save\normal-view.howku
	FileCopy, %A_WorkingDir%\profiles\select\Normal\usersettings.cfg, %A_WorkingDir%\config\
	FileCopy, %A_WorkingDir%\profiles\select\Normal\small.cfg, %A_WorkingDir%\profiles\select\
	HideTrayTip()
	TrayTip,, normal Tablet-view
	WinKill, Tabletdriver
	reload
	return
}
if FileExist("save\normal-view.howku")
{
	FileDelete, %A_WorkingDir%\save\normal-view.howku
	FileDelete, %A_WorkingDir%\config\usersettings.cfg
	FileDelete, %A_WorkingDir%\profiles\select\small.cfg

	FileAppend,, %A_WorkingDir%\save\upsidedown-view.howku
	FileCopy, %A_WorkingDir%\profiles\select\upsidedown\usersettings.cfg, %A_WorkingDir%\config\
	FileCopy, %A_WorkingDir%\profiles\select\upsidedown\small.cfg, %A_WorkingDir%\profiles\select\
	HideTrayTip()
	TrayTip,, upsidedown Tablet-view
	WinKill, Tabletdriver
	reload
	return
}
Else
{
	FileAppend,, %A_WorkingDir%\save\normal-view.howku
	return
}










f14::
if GetKeyState("Lbutton", "P"){
    send, {Lbutton up}
	return
}
else{
    send {Lbutton up}{Rbutton}
	return
}





;#########################################################################################################################################################################################
;#########################################################################################################################################################################################
;#########################################################################################################################################################################################
;###############################=############################################################################################################################################################
;Script-addons/Tray-refresh.ahk
Tray_Refresh() {
	WM_MOUSEMOVE := 0x200
	detectHiddenWin := A_DetectHiddenWindows
	DetectHiddenWindows, On

	allTitles := ["ahk_class Shell_TrayWnd"
			, "ahk_class NotifyIconOverflowWindow"]
	allControls := ["ToolbarWindow321"
				,"ToolbarWindow322"
				,"ToolbarWindow323"
				,"ToolbarWindow324"]
	allIconSizes := [24,32]

	for id, title in allTitles {
		for id, controlName in allControls
		{
			for id, iconSize in allIconSizes
			{
				ControlGetPos, xTray,yTray,wdTray,htTray,% controlName,% title
				y := htTray - 10
				While (y > 0)
				{
					x := wdTray - iconSize/2
					While (x > 0)
					{
						point := (y << 16) + x
						PostMessage,% WM_MOUSEMOVE, 0,% point,% controlName,% title
						x -= iconSize/2
					}
					y -= iconSize/2
				}
			}
		}
	}

	DetectHiddenWindows, %detectHiddenWin%
}
;#########################################################################################################################################################################################
;#########################################################################################################################################################################################
;#########################################################################################################################################################################################
;##############################=#############################################################################################################################################################
;#########################################################################################################################################################################################
;#########################################################################################################################################################################################
;########################################################################################################################################################################################

;####################################################################
;####################################################################
;####################################################################
;####################################################################
;####################################################################
;####################################################################
;####################################################################
;####################################################################
;####################################################################
;####################################################################
cmd:
Winshow, Tabletdriver
return

^+!f11::
WinKill, Tabletdriver
Tray_Refresh()
reload

