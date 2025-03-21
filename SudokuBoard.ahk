#Requires AutoHotkey v2.0
#SingleInstance Force
; Sets absolute coordinates for tooltip
CoordMode("ToolTip", "Screen")
CoordMode("Mouse", "Screen")
; Sets Mouse Move Speed
SetDefaultMouseSpeed 0
; Set Tray Icon
TraySetIcon("./assets/icon-file/icon.ico")
#Include ./util/ini-functions.ahk
; ============================== MAIN VARIABLES ==============================
; This is the tracker that determines the current layer
; Also the layer that k-plus starts up with
currentLayer := "Entry"

; Tooltip and coordinate settings; whether or not to have a tooltip active and where it should be located
tooltipOn := readConfigSettings("tooltipOn")
xCoordinate := readConfigSettings("xCoordinate")
yCoordinate := readConfigSettings("yCoordinate")

; rootSqrSize refers to the length of both the large and small squares that make up the sudoku grid
; Future iterations may include navigation support for larger and smaller sudoku grids, as long as the large and small squares have the same side length, the conversion equations should still work. Probably.
sqrSize := 9
rootSqrSize := Sqrt(SqrSize)

; Whether or not a pencil mark mode for web sudoku is accessible
webSudokuPencilMarks := readConfigSettings("webSudokuPencilMarks") || 0

; Array that holds the current cartesian coordinates of the cursor
; Squares are counted 1-9 starting at the top left
; Coordinates default to 1, 1 so that mouse mode, once automatically calibrated, will work out of the box
; Since mouse mode moves the mouse directly to coordinates, rather than sending X arrow key inputs, it doesn't technically need to track the current coordinates
cartesianCoordinates := [1, 1]

; Array that tracks box coordinates for navigation and initial coordinate setting
boxCoordinates := []

; Holds matrix containing saved pencil mark data
pencilMatrix := []
; Adds rows (outer loop) and empty arrays for each cell (inner loop)
Loop sqrSize {
    loopNum := A_Index
    pencilMatrix.Push([])
    Loop sqrSize {
        pencilMatrix[loopNum].Push("")
    }
}

; Universal quit and suspend key definitions go here
; Edit key defitions and input level as desired
#InputLevel 2
#SuspendExempt True
; The suspend shortcut also disables the tooltip if it was active, though the tooltip remains if suspended via the GUI
^!+s::Suspend(-1)
^!+q::ExitApp
; Hotkeys for mouse mode
; For some reason these need to be within the suspend exempt section, otherwise they don't work; this is an ongoing issue
^!+c::mouseCalibration()
^!+m::mouseModeToggle()
#SuspendExempt False

; ============================== MOUSE MODE VARIABLES AND FUNCTIONS ==============================
#Include ./util/mouse-calibration.ahk

; Whether or not to move cursor via mouse or arrow keys
mouseMode := readMouseSettings("mouseMode") || 0
; Values for mouse position calculation
startPositionX := readMouseSettings("startPositionX") || 0
startPositionY := readMouseSettings("startPositionY") || 0
xOffset := readMouseSettings("xOffset") || 0
yOffset := readMouseSettings("yOffset") || 0

; If the proper values don't exist, automatically trigger mouse calibration when trying to switch to mouse mode
; Placed here in case of starting in mouse mode
if(mouseMode && !(startPositionX && startPositionY && xOffset && yOffset)){
    ; Shut off mouse mode before entering calibration
    mouseModeToggle()
    mouseCalibration()
}

; Adding tray menu items
A_TrayMenu.Add("Mouse Mode", mouseModeToggleMenu)
A_TrayMenu.Add("Mouse Calibration", mouseCalibrationMenu)

; Functions for the tray menu must take specific parameters, so these are just wrappers
mouseModeToggleMenu(ItemName, ItemPos, MyMenu){
    mouseModeToggle()
}

mouseCalibrationMenu(ItemName, ItemPos, MyMenu){
    mouseCalibration()
}

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
        ToolTip(tooltipTextGenerator(), xCoordinate, yCoordinate)
    }
}

; Runs ToolTip at start
if(tooltipOn){
    Tooltip(tooltipTextGenerator(), xCoordinate, ycoordinate)
}

; ============================== TOGGLE LAYERS ==============================
toggleLayer(targetLayer) {
    global
    currentLayer := targetLayer
    boxCoordinates := []
    if(tooltipOn){
        Tooltip(tooltipTextGenerator(), xCoordinate, yCoordinate)
    }
}

; ============================== UTILITY FUNCTIONS ==============================
tooltipTextGenerator(){
    global
    ifMouseMode := ""
    if(mouseMode){
        ifMouseMode := "`nMouse Mode Engaged"
    }
    tooltipText :=
    (
        "Current Layer: " currentLayer " " ifMouseMode "
        ------------------------
        |_____w________u_i_o__|
        |__a__s__d_____j_k_l___|
        |______________m_,_.___|
        |______________________|
        "
    )
    Return tooltipText
}

; Function to toggle whether or not the script displays a tooltip, for use in layers
tooltipToggle(){
    global
    tooltipOn := tooltipOn ? 0 : 1
    if(tooltipOn){
        ToolTip(tooltipTextGenerator(), xCoordinate, yCoordinate)
    } else {
        ToolTip()
    }
}

; Simple function to toggle mouse mode on and off
mouseModeToggle(){
    global
    mouseMode := mouseMode ? 0 : 1

    ; If the proper values don't exist, automatically trigger mouse calibration when trying to switch to mouse mode
    if(mouseMode && !(startPositionX && startPositionY && xOffset && yOffset)){
        mouseMode := mouseMode ? 0 : 1
        mouseCalibration()
        Return
    }
    ToolTip(tooltipTextGenerator(), xCoordinate, yCoordinate)
}

; These two functions handle conversion between the two kinds of coordinate systems
; For now, only the equation for calculating the little box is needed, but I'm leaving the big box calcuation here in case it's needed
; Round is nessecary to make sure the result is a simple integer, without any decimal places
cartesianToBox(coordArr){
    x := coordArr[1]
    y := coordArr[2]

    a := Round(Ceil(x/rootSqrSize) + ((Ceil(y/rootSqrSize)-1)*3))
    b := Round((Mod((x-1), rootSqrSize)) + ((Mod((y-1), rootSqrSize)*rootSqrSize)+1))
    Return [a, b]
}

boxToCartesian(coordArr){
    a := coordArr[1]
    b := coordArr[2]

    x := Round((Mod((a-1), rootSqrSize)*3) + (Mod((b-1), rootSqrSize)+1))
    y := Round((a-(Mod((a-1), rootSqrSize))) + (Ceil(b/3)-1))
    Return [x, y]
}

; Set starting coordinates by monitoring the box array, and once it fills up setting the cartesian coordinates accordingly
setCoord(num){
    global
    boxCoordinates.Push(num)
    if (boxCoordinates.length = 2){
        cartesianCoordinates := boxToCartesian([boxCoordinates[1], boxCoordinates[2]])
        toggleLayer("Entry")
    }
    if (boxCoordinates.length = 2){
        boxCoordinates := []
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
        if(mouseMode){
            mouseMovement(cartesianCoordinates)
        } else {
            cursorMove([difference, 0])
        }
    } else if (xOrY = "y"){
        oldY := cartesianCoordinates[2]
        cartesianCoordinates[2] := Mod((cartesianCoordinates[2] + movement), sqrSize) || sqrSize
        difference := cartesianCoordinates[2] - oldY
        if(mouseMode){
            mouseMovement(cartesianCoordinates)
        } else {
            cursorMove([0, difference])
        }
    }
}

; This function handles the primary 3x3 block navigation
; The idea is that upon entering the big box key, the cursor immediately navigates to that large box in that relative position, navigating to the smaller box only on a second press
navigate(num){
    global
    boxCoordinates.Push(num)

    if (boxCoordinates.length = 1){
        currentBoxCoord := cartesianToBox([cartesianCoordinates[1], cartesianCoordinates[2]])
        targetCoord := boxToCartesian([boxCoordinates[1], currentBoxCoord[2]])
        ; The difference is calculated as new vs old then sent to the appropriate movement function
        movementArr := [targetCoord[1]-cartesianCoordinates[1], targetCoord[2]-cartesianCoordinates[2]]
        if (mouseMode){
            mouseMovement(targetCoord)
        } else {
            cursorMove(movementArr)
        }
    } else if (boxCoordinates.length = 2){
        ; If this is the second number entered then the current box coordinates are used directly, resulting in a movement within one a box rather than between
        targetCoord := boxToCartesian(boxCoordinates)
        movementArr := [targetCoord[1]-cartesianCoordinates[1], targetCoord[2]-cartesianCoordinates[2]]
        if (mouseMode){
            mouseMovement(targetCoord)
        } else {
            cursorMove(movementArr)
        }
        boxCoordinates := []
    }
    cartesianCoordinates := targetCoord
}

; Handles moving the cursor via arrow key inputs the correct amount
; Parameters come in either negative or positive; the sign indicates the direction and the Absolute() function detrmines the distance of the movement
; The distance can be 0, letting the function move the cursor in just one direction
cursorMove(movementArr){
    (movementArr[1] > 0) ? SendInput("{Right " Abs(movementArr[1]) "}") : SendInput("{Left " Abs(movementArr[1]) "}")
    (movementArr[2] > 0) ? SendInput("{Down " Abs(movementArr[2]) "}") : SendInput("{Up " Abs(movementArr[2]) "}")
    ; ToolTip(cartesianCoordinates[1] cartesianCoordinates[2])
}

; Handles moving the mouse to the inputted coordinates for Mouse Mode
mouseMovement(targetCoord){
    global
    ; Formula for calculating the screen coordinates based on the starting position, the offsets, and the cartesian coordinates; the one at the end is the number of clicks
    Click((startPositionX + ((targetCoord[1] - 1) * xOffset)) " " (startPositionY + ((targetCoord[2]-1) * yOffset)) " 1")
    ; Keeps mouse out of the way
    ; MouseMove(startPositionX - xOffset, (startPositionY + ((targetCoord[2]-1) * yOffset)), 0)
    ; ToolTip(cartesianCoordinates[1] cartesianCoordinates[2])
}

; Simple function that is used to make sure pencil marks are erased in the matrix
erase(){
    ; When the user triggers an erase, this will wipe any existing stored pencil marks
    pencilMatrix[cartesianCoordinates[1]][cartesianCoordinates[2]] := ""
    SendInput("^{Backspace}")
}

; Function for inputting numbers, with additional logic to handle pencil marks for websudoku.com
entry(numStr){
    ; If mode is deactivated, simply send the relevant number
    if(!webSudokuPencilMarks){
        SendInput(numStr)
        Return
    }
    cellMarks := pencilMatrix[cartesianCoordinates[1]][cartesianCoordinates[2]]

    if(!cellMarks){
        pencilMatrix[cartesianCoordinates[1]][cartesianCoordinates[2]] := numStr
        SendInput(numStr)
    } else {
       pencilMark(numStr) 
    }
}

; Function to track and update pencil marks
pencilMark(mark){
    global
    ; Stores cureent marks
    cellMarks := pencilMatrix[cartesianCoordinates[1]][cartesianCoordinates[2]]
    ; Placeholder variable to build out pencil marks minus those to be removed
    newPencilmarks := ""

    ; Tracks whether this function was called to remove an item or ad it
    removedMarks := 0
    ; Entries that already exist should be removed
    Loop Parse cellMarks{
        if(A_LoopField = mark){
            removedMarks := 1
            Continue
        }
        newPencilmarks .= A_LoopField
    }
    cellMarks := newPencilmarks

    ; The websudoku site only allows 5 entries, so if the cell is already full nothing should change
    if(StrLen(cellMarks) <= 5){
        if(!removedMarks){
            cellMarks .= mark
        }

        if(StrLen(cellMarks) > 2){
            cellMarks := StrReplace(cellMarks, ".")
        }

        ; Add delimeters for sorting
        newPencilmarks := ""
        Loop Parse cellMarks{
            newPencilmarks .= A_LoopField
            newPencilmarks .= ","
        }
        cellMarks := Sort(newPencilmarks, "N D,")
        cellMarks := StrReplace(cellMarks, ",")
    }
    ; Save the marks before adding the extra dot so that the dot isn't saved
    pencilMatrix[cartesianCoordinates[1]][cartesianCoordinates[2]] := cellMarks

    if(StrLen(cellMarks) = 1){
        ; Add just the . when there is just one pencil mark so that the pencil mark is never just a single digit
        cellMarks .= "."
    }
    ; Starts by clearing the input field so that a new sorted list can be entered
    SendInput("^{Backspace}" cellMarks)
}

; ============================== INCLUDE HOTKEYS ==============================
; Ensures the input level is above the default for other scripts
#InputLevel 1

#Include ./layers/layers-9x9/entry.ahk
#Include ./layers/layers-9x9/navigation.ahk
#Include ./layers/layers-9x9/set-coordinates.ahk
#HotIf
