#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force
#InstallKeybdHook

;Check if Resolve is playing.
IsPlaying()
{
    CoordMode Pixel
    PixelSearch, Px, Py, X1, Y1, X2, Y2, 0xE64B3D, 0,Fast RGB ; Edit X1, Y1, X2, Y2 to the region in which the red play indicator is on your display.
    if (ErrorLevel == True){
        return False
    }
    CoordMode Pixel
    PixelGetColor, OutputVar, Px+1, Py+10 , Fast RGB
    if (OutputVar != 0xE64B3D){
        return False
    }
    CoordMode Pixel
    PixelGetColor, OutputVar, Px+5, Py+12 , Fast RGB
    if (OutputVar != 0xE64B3D){
        return False
}
    return True
}
;Can use Middle mouse button to move playhead. Stops if middle of playing like premiere
#IfWinActive ahk_exe Resolve.exe
MButton::
if IsPlaying()
{
    Send {Space}
}
Send {LButton down}
Loop
{
    Sleep, 10
    if !GetKeyState("MButton", "P")
        break
}
Send {LButton up}
return

;Can hold down s to toggle snap
#If GetKeyState("Ctrl") == 0 && GetKeyState("Alt") == 0 && GetKeyState("Shift") == 0 && WinActive("ahk_exe Resolve.exe") && InStr(A_Cursor,"eam") == 0
s::

;Send N
Send {n}
pp :=GetKeyState("LButton","P") == 1

;START!!!
start := False

;Wait for LMB to be pressed or S to be released
while GetKeyState("s","P") == 1 {
    if GetKeyState("LButton","P") == 1 {
        start := True 
        break
    }
    Sleep, 10
}
;Leave if nothing happend
if (start == False) {
    Send {n}
    return
}

;STEP_1!!!
MouseGetPos, start_x, start_y
step_1 := False
while (GetKeyState("s","P") == 1) {
    MouseGetPos, x, y
    if (x != start_x || y != start_y) {
        step_1 := True
        break
    }
    Sleep, 10
}
;Leave if nothing happend
if (step_1 == False) {
    Send {n}
    return
}

;STEP_2!!!
step_2 := False
while GetKeyState("s","P") == 1 {
    if GetKeyState("LButton","P") == 0 {
        step_2 := True
        break
    }
    Sleep, 10
}
while GetKeyState("LButton","P") == 1  || GetKeyState("s","P") == 1 {
    Sleep, 10
}
if (step_2 == 1 && pp == 0) {
    Send {n}
    return
}
if (step_2 == 0 && pp == 0) {
    Send {n}
    return
}
return



 
