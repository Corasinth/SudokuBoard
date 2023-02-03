#Requires AutoHotkey v2.0
#SingleInstance Force
; Sets absolute coordinates for tooltip
CoordMode("ToolTip", "Screen")
; ============================== MAIN VARIABLES ==============================
; This is the tracker that determines the current layer
; Also the layer that k-plus starts up with
currentLayer := "Entry"

; Tooltip and coordinate settings; whether or not to have a tooltip active and where it should be located
tooltipOn := 1
xCoordinate := 1920
yCoordinate := 1080

; sqrSize refers to the length of both the large and small squares that make up the sudoku grid
; Future iterations may include navigation support for larger and smaller sudoku grids, as long as the large and small squares have the same side length, the conversion equations should still work. Probably.
sqrSize := 3



; Universal quit and suspend key definitions go here
; Edit key defitions and input level as desired
#InputLevel 0
#SuspendExempt True
; The suspend shortcut also disables the tooltip if it was active, though the tooltip remains if suspended via the GUI
^!+s::Suspend(-1)
^!+q::ExitApp
#SuspendExempt False

; ============================== TOOLTIP HANDLING ==============================
SuspendC := Suspend.GetMethod("Call")
Suspend.DefineProp("Call", {
Call:(this, mode:=-1) => (SuspendC(this, mode), OnSuspend(A_IsSuspended))
})
OnMessage(0x111, OnSuspendMsg)
OnSuspendMsg(wp, *) {
    if ((wp = 65305) || (wp = 65404)){
        OnSuspend(!A_IsSuspended)
    }
}

; wp numbers grabbed via this bit of code
; OnMessage(0x111, WM_COMMAND)

; WM_COMMAND(wparam, lparam, msg, hwnd) {
;     OutputDebug "wp: " wparam " | lp: " lparam "`n"
; }
OnSuspend(mode) {
    global
    if (tooltipOn && mode = 1){
        ToolTip()
    } else if (tooltipOn && mode = 0){
        ToolTip(currentLayer, xCoordinate, yCoordinate)
    }
}

; Runs ToolTip at start
if(tooltipOn){
    Tooltip(currentLayer, xCoordinate, ycoordinate)
}

; ============================== TOGGLE LAYERS ==============================
toggleLayer(targetLayer) {
    global
    if(tooltipOn){
        Tooltip(currentLayer, xCoordinate, yCoordinate)
    }
}

; ============================== UTILITY FUNCTIONS ==============================
; Function to toggle whether or not the script displays a tooltip, for use in layers
tooltipToggle(){
    tooltipOn := tooltipOn ? 0 : 1
    if(tooltipOn){
        ToolTip(currentLayer, xCoordinate, yCoordinate)
    } else {
        ToolTip()
    }
}

sqrSize := 3

; a := 1
; b := 5

x := 2
y := 8

a := Ceil(x/sqrSize) + ((Ceil(y/sqrSize)-1)*3)
b := (Mod((x-1), sqrSize)) + ((Mod((y-1), sqrSize)*sqrSize)+1)

; x := (Mod((a-1), sqrSize)*3) + (Mod((b-1), sqrSize)+1)
; y := (a-(Mod((a-1), sqrSize))) + (Ceil(b/3)-1)


MsgBox("Box Coordinates: " a ", " b)

; MsgBox("Box Coordinates: " x ", " y)

; ============================== INCLUDE HOTKEYS ==============================
; Ensures the input level is above the default for other scripts
#InputLevel 1
; Include master file of layers. This file contains nothing but #Include commands for the rest of the config files
#Include ./layers/entry.ahk
#Include ./layers/navigation.ahk
#Include ./layers/set-coordinates.ahk
#HotIf