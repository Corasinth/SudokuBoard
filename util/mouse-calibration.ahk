#Requires AutoHotkey v2.0
#SingleInstance Force
CoordMode("Mouse", "Screen")

mouseCalibration(){
    global

    topLeft := ""
    topRight := ""
    bottomLeft := ""
    bottomRight := ""

    mouseCalText := "Welcome to the SudokuBoard mouse calibration!`n`nMouse calibration is important for mouse mode, where the navigation keys move the mouse around, rather than the cursor.`n`nTo calibrate your mouse, you'll need to click the four corners of the sudoku grid in the following order: top left (🡠), top right (🡢), bottom left (🡠), and bottom right (🡢).`n`nIt is important to position the puzzle as desired before continuing; if it is not please cancel calibration and adjust the puzzle appropriately. Otherwise, you will experiance inputs in unexpected places.`n`nIf you experiance troubles with mouse mode, try recalibrating.`n`nFor those who wish to be precise, the arrow and WASD keys will move the cursor one pixel in the appropiate direction during calibration, but extreme accuracy is not required for successful calibration.`n`nClick 'OK' to continue with mouse calibration, or 'Cancel' if you don't wish to proceed."
    result := MsgBox(mouseCalText, "Mouse Calibration", "OKCancel")
    if (result = "Cancel"){
        ; toggleLayer("Entry")
        Return
    }
    tooltipText := "Please click on the top left (🡠) corner of the sudoku grid."
    tooltipText := "Please click on the top right (🡢) corner of the sudoku grid."
    tooltipText := "Please click on the bottom left (🡠) corner of the sudoku grid."
    tooltipText := "Please click on the bottom right (🡢) corner of the sudoku grid."

    SetTimer(checkPosition, 20)

    ; tickingTooltip(8)

    tickingTooltip("6", -1)
    tickingTooltip("5", -1000)
    tickingTooltip("4", -2000)
    tickingTooltip("3", -3000)
    tickingTooltip("2", -4000)
    tickingTooltip("1", -5000)
    tickingTooltip("0", -6000)

}

; tickingTooltip(countdownFrom){
;     global
;     Loop countdownFrom {
;         secondsRemaining := countdownFrom - A_Index
;         timer := A_Index * -1000
;         if(secondsRemaining = 0){
;             SetTimer(closeToolTip, timer)
;         }
;         SetTimer(() => tooltipText := "This tooltip will shut off in " secondsRemaining " seconds.", timer)
;         ; SetTimer(() => MsgBox("sttt"), timer)
;     }
; }

tickingTooltip(secondsRemaining, timer){
    global
    SetTimer(() => tooltipText := "Received coordinates " bottomRight "This tooltip will shut off in " secondsRemaining " seconds.", timer)
}

checkPosition(){
    MouseGetPos(&xx, &yy)
    ToolTip(tooltipText " Current Coordinates: " xx ", " yy,,,2)
}

closeToolTip(){
    SetTimer(checkPosition, 0)
    Tooltip(,,,2)
}

mouseCalibration()
Esc::ExitApp