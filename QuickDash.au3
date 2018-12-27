#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=QuickDash (x86).exe
#AutoIt3Wrapper_Outfile_x64=QuickDash (x64).exe
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Fileversion=1.0
#AutoIt3Wrapper_Res_Language=1031
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         c0derMo

 Script Function:
	Quick-Access commandline for short commands

#ce ----------------------------------------------------------------------------

#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>
#include <Process.au3>
#include <Misc.au3>

;Initialise Variables
$ini = @ScriptDir & "/config.ini"
$ini_jumps = "CMDS"

;Create QuickDash-Window
GUICreate("QuickDash", 200, 40, -1, -1,  BitOR($WS_POPUPWINDOW, $WS_POPUP))
GUISetBkColor(0x000000)
$input = GUICtrlCreateInput("", 0, 8, 200, 24, $ES_CENTER, $WS_EX_TRANSPARENT)
GUICtrlSetBkColor(-1, 0x000000)
GUICtrlSetFont(-1, 16)
GUICtrlSetColor(-1, 0x009933)
GUISetState(@SW_HIDE)

;Create Hotkeys
HotKeySet("!-", "dashshow")
HotKeySet("^!{F4}", "killwindow")
HotKeySet("!+#s", "pcsleep")

while True

$nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            dashhide()
        Case $input
            dashjump()
    EndSwitch

WEnd

;QuickDash-Functions
Func dashshow()
	GUISetState(@SW_SHOW)
EndFunc

Func dashhide()
	GUICtrlSetData($input, "")
	GUISetState(@SW_HIDE)
EndFunc

Func dashjump()
	If _IsPressed("1B") Then
		dashhide()
	Else
		$text = GUICtrlRead($input)
		If ($text == "exit") Then
			Exit
		ElseIf ($text == "ini") Then
			ShellExecute($ini)
			dashhide()
		Else
			$cmd = IniRead($ini, $ini_jumps, $text, "")
			if ($cmd <> "") Then
				ShellExecute($cmd)
				dashhide()
			EndIf
		EndIf
	EndIf
EndFunc


;Addon Hotkey-Functions
Func killwindow()
	ProcessClose(_ProcessGetName(WinGetProcess("[ACTIVE]")))
EndFunc

Func pcsleep()
	ShellExecute("rundll32.exe", "powrprof.dll,SetSuspendState 0,1,0")
EndFunc