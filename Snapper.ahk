; This AutoHotKey script is intended to help people use Davinci Resolve.
; It allows you to use the shift key to temporarily enable snapping when a clip is being dragged.
; This is the default in Premiere Pro. This script brings that shortcut to Resolve.

#NoEnv
#SingleInstance, Force
#InstallKeybdHook
SendMode Input
SetWorkingDir, %A_ScriptDir%


; If Control and Alt is not pressed | Resolve is active
#If GetKeyState("Ctrl") == 0 && GetKeyState("Alt") == 0 && GetKeyState("LButton") == 1 && WinActive("ahk_exe Resolve.exe")
RShift::
Send {n}
keywait, RShift
return

; If Control and Alt is not pressed | Resolve is active
#If GetKeyState("Ctrl") == 0 && GetKeyState("Alt") == 0 && GetKeyState("LButton") == 1 && WinActive("ahk_exe Resolve.exe")
LShift::
Send {n}
keywait, LShift
return
