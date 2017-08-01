; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

; This script has a special filename and path because it is automatically
; launched when you run the program directly.  Also, any text file whose
; name ends in .ahk is associated with the program, which means that it
; can be launched simply by double-clicking it.  You can have as many .ahk
; files as you want, located in any folder.  You can also run more than
; one .ahk file simultaneously and each will get its own tray icon.

; SAMPLE HOTKEYS: Below are two sample hotkeys.  The first is Win+Z and it
; launches a web site in the default browser.  The second is Control+Alt+N
; and it launches a new Notepad window (or activates an existing one).  To
; try out these hotkeys, run AutoHotkey again, which will load this file.

; ^  -- Control
; +  -- Shift
; !  -- Alt


#!u::ResizeWin(600,0)
!;::SubtractFromWinWidth(100)
!'::AddToWinWidth(100)

; click to focuse the window under the cursor and then paste with middle mouse button
MButton::Send {LButton}^v


ResizeWin(Width = 0,Height = 0)
{
    WinGetPos,X,Y,W,H,A
    If %Width% = 0
        Width := W

    If %Height% = 0
        Height := H

    WinMove,A,,%X%,%Y%,%Width%,%Height%
}


AddToWinWidth(Width)
{
    WinGetPos,X,Y,W,H,A
    W += %Width% 
    WinMove,A,,%X%,%Y%,%W%,%Height%

}
SubtractFromWinWidth(Width)
{
    WinGetPos,X,Y,W,H,A
    W -= %Width% 
    WinMove,A,,%X%,%Y%,%W%,%Height%

}


; let CapsLock act like Enter
Capslock::Enter
; let shift-capslock act like normal capslock
+Capslock::Capslock

; let CapsLock act like BackspaceCapslock::Backspace
;Capslock::Backspace




;;;; disable left control 
;;;; except for Sql Server Management Studio 
;;;; SetTitleMatchMode, 2
;;;; #IfWinNotActive, SQL Server Management Studio
;;;; {
;;;;    LCtrl::return
;;;; }


; Putty specific commands - assumes tmux is running in Putty
;use F3 to send the command prefix (Ctrl-b)
;use F4 to cycle through panes
;use F5 to spawn a new pane below the current pane
;use F6 to spawn a new window
;use F7 to spawn a new pane to the right of the current pane
;use F9/F10 to move to previous/next sessions
;use F11/F12 to move tmux to the previous/next windows
;use ALT to get to the original key
#IfWinActive, ahk_class PuTTY

F2::Send .
F3::Send ^b
F4::Send ^bo
F5::Send ^b"
F6::Send ^bc
F7::Send ^b`%
;F9::Send ^b(
;F10::Send ^b)
F11::Send ^bp
F12::Send ^bn

!F3::Send {F3}
!F4::Send {F4}
!F5::Send {F5}
!F6::Send {F6}
!F7::Send {F7}
;;; !F9::Send {F9}
;;; !F10::Send {F10}
!F11::Send {F11}
!F12::Send {F12}


!w::Send {Up}
!a::Send {Left}
!s::Send {Down}
!d::Send {Right}

return


; let Shift-Insert paste to DOS/PowerShell windows via Alt-Space -> Edit -> Paste
#IfWinActive, ahk_class ConsoleWindowClass
+Insert::Send !{Space}ep
return



#IfWinActive, ahk_class MozillaWindowClass
F11::Send ^{PgUp}
F12::Send ^{PgDn}
return





; changing window transparencies
; Win+PageUp
#PgUp::  ; Increments transparency up by 3.375% (with wrap-around)
    DetectHiddenWindows, on
    WinGet, curtrans, Transparent, A
    if ! curtrans
        curtrans = 255
    newtrans := curtrans + 8
    if newtrans > 0
    {
        WinSet, Transparent, %newtrans%, A
    }
    else
    {
        WinSet, Transparent, OFF, A
        WinSet, Transparent, 255, A
    }
return

; Win+PageDown
#PgDn::  ; Increments transparency down by 3.375% (with wrap-around)
    DetectHiddenWindows, on
    WinGet, curtrans, Transparent, A
    if ! curtrans
        curtrans = 255
    newtrans := curtrans - 8
    if newtrans > 0
    {
        WinSet, Transparent, %newtrans%, A
    }
    ;else
    ;{
    ;    WinSet, Transparent, 255, A
    ;    WinSet, Transparent, OFF, A
    ;}
return

; Win+-
#-::  ; Reset Transparency Settings
    WinSet, Transparent, 255, A
    WinSet, Transparent, OFF, A
return

; Win+=
#=::  ; show the current settings of the window under the mouse.
    MouseGetPos,,, MouseWin
    WinGet, Transparent, Transparent, ahk_id %MouseWin%
    ToolTip Translucency:`t%Transparent%`n
	Sleep 2000
	ToolTip
return

