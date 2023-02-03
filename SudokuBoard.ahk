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

; rootSqrSize refers to the length of both the large and small squares that make up the sudoku grid
; Future iterations may include navigation support for larger and smaller sudoku grids, as long as the large and small squares have the same side length, the conversion equations should still work. Probably.
sqrSize := 9
rootSqrSize := Sqrt(SqrSize)

; Array that holds the current cartesian coordinates of the cursor
; Squares are counted 1-9 starting at the top left
cartesianCoordinates := [0, 0]

; Array that tracks box coordinates for navigation and initial coordinate setting
boxCoordinates := []

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

; These two functions handle conversion between the two kinds of coordinate systems
; For now, only the equation for calculating the little box is needed, but I'm leaving the big box calcuation here in case it's needed
cartesianToBox(x, y){
    ; a := Ceil(x/rootSqrSize) + ((Ceil(y/rootSqrSize)-1)*3)
    b := (Mod((x-1), rootSqrSize)) + ((Mod((y-1), rootSqrSize)*rootSqrSize)+1)
    Return b
}

boxToCartesian(a, b){
    x := (Mod((a-1), rootSqrSize)*3) + (Mod((b-1), rootSqrSize)+1)
    y := (a-(Mod((a-1), rootSqrSize))) + (Ceil(b/3)-1)
    Return [x, y]
}

; Set starting coordinates by monitoring the box array, and once it fills up setting the cartesian coordinates accordingly
setCoord(num){
    global
    if (boxCoordinates.length >= 2){
        boxCoordinates := []
    }
    boxCoordinates.Push(num)
    if (boxCoordinates.length = 2){
        cartesianCoordinates := boxToCartesian(boxCoordinates[1], boxCoordinates[2])
        toggleLayer("Entry")
    }
}

; This function handles updating the coordinates when using the arrow keys/WASD, and then sending the appropriate cursor instructions
; The function also automatically wraps, so moving the cursor down at the limit of the grid will result in moving back to the top
coordUpdate(xOrY, movement){
    global
    if (xOrY = "x"){
        oldX := cartesianCoordinates[1]
        ; The equation below enables automatic wrapping
        ; Essentially, if the updated coordinates are 0 or above the square size, the coordinates get set to the square size or 1 respectively
        ; If the updated coordinates are at the maximum, the equation results in 0. Since this reads as false, they default to the maximum square size
        cartesianCoordinates[1] := Mod((cartesianCoordinates[1] + movement), sqrSize) || sqrSize
        difference := cartesianCoordinates[1] - oldX
        cursorMove(difference, 0)
    } else if (xOrY = "y"){
        oldY:= cartesianCoordinates[2]
        cartesianCoordinates[1] := Mod((cartesianCoordinates[2] + movement), sqrSize) || sqrSize
        difference := cartesianCoordinates[1] - oldX
        cursorMove(0, difference)
    }
}

; Handles moving the cursor via arrow key inputs the correct amount
; Parameters come in either negative or positive; the sign indicates the direction and the Absolute() function detrmines the distance of the movement
; The distance can be 0, letting the function move the cursor in just one direction
cursorMove(x, y){
    x > 0 ? SendInput("{Right " Abs(x) "}") : SendInput("{Left " Abs(x) "}")
    y > 0 ? SendInput("{Down " Abs(y) "}") : SendInput("Up" Abs(y) "}")
}

; Function for updating cartesian coordinates that automatically wraps
; Function for taking navigation requests, checking how many navigations have been receives since last cycle, and generating and executing appropriate arrow commands
; This must also translate destination coordinates into cartesian coordinates, and assign inner box destination when using big box navigation only (which means translating cartesian to box, detrmining box coords, and translating back to cartesian
; Perhaps functions for translating cartesian to box and box to cartesian

; ============================== INCLUDE HOTKEYS ==============================
; Ensures the input level is above the default for other scripts
#InputLevel 1
; Include master file of layers. This file contains nothing but #Include commands for the rest of the config files
#Include ./layers/entry.ahk
#Include ./layers/navigation.ahk
#Include ./layers/set-coordinates.ahk
#HotIf