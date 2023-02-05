#Requires AutoHotkey v2.0
#SingleInstance Force
CoordMode("Mouse", "Screen")
#Include ../layers/calibration.ahk

currentLayer := "on"
toggleLayer(target){
    global
    currentLayer := target
}

mouseCalibration(){
    global
    ; Stores coordinates gained from left click
    sudokuCoordinates := []

    ; Text for dialogue boxes
    mouseCalText := "Welcome to the SudokuBoard mouse calibration!`n`nMouse calibration is important for mouse mode, where the navigation keys move the mouse around, rather than the cursor.`n`nTo calibrate your mouse, you'll need to click the four corners of the sudoku grid in the following order: top left (🡠), top right (🡢), bottom left (🡠), and bottom right (🡢).`n`nIt is important to position the puzzle as desired before continuing; if it is not please cancel calibration and adjust the puzzle appropriately. Otherwise, you will experiance inputs in unexpected places.`n`nIf you experiance troubles with mouse mode, try recalibrating.`n`nFor those who wish to be precise, the arrow and WASD keys will move the cursor one pixel in the appropiate direction during calibration, but extreme accuracy is not required for successful calibration.`n`nClick 'OK' to continue with mouse calibration, or 'Cancel' if you don't wish to proceed."
    postCalText := "Mouse calibration completed!`n`nYou have entered the following coordinates: `n`nIf these are acceptable, click continue. If you wish to recalibrate, click Try Again. If you wish to abort calibration, click cancel.`n`nFinally, if you want to save this calibration as the default, check the box below.`n`nWARNING! This will overwrite the current settings. If you wish to save your current settings, you must make the appropriate arrangements to save those."

    result := MsgBox(mouseCalText, "Mouse Calibration", "OKCancel")
    if (result = "Cancel"){
        toggleLayer("Entry")
        Return
    }

    tooltipText := "Please click on the top left (🡠) corner of the sudoku grid."
    ; Displays coordinates in a tooltip for those who like the precision
    SetTimer(checkPosition, 20)
    ; Calibration layer holds the hotkey that saves mouse coordinates to the relevant array on click
    toggleLayer("Calibration")

    tooltipText := "Please click on the top right (🡢) corner of the sudoku grid."
    tooltipText := "Please click on the bottom left (🡠) corner of the sudoku grid."
    tooltipText := "Please click on the bottom right (🡢) corner of the sudoku grid."

    ; tickingTooltip(8)

    tickingTooltip("6", -1)
    tickingTooltip("5", -1000)
    tickingTooltip("4", -2000)
    tickingTooltip("3", -3000)
    tickingTooltip("2", -4000)
    tickingTooltip("1", -5000)
    tickingTooltip("0", -6000)
    SetTimer(closeToolTip, -6000)




    result := MsgBox(postCalText, "Mouse Calibration Complete", "CancelTryAgainContinue")

    ; Not strictly necessary, but splitting up the coordinates into seperate variables makes them easier to do calculations on
    topLeftCorner := sudokuCoordinates[1]
    topRightCorner := sudokuCoordinates[2]
    bottomLeftCorner := sudokuCoordinates[3]
    bottomRightCorner := sudokuCoordinates[4]

    ; Reset the sudokuCoordinates regardless of the result of the dialogue box
    sudokuCoordinates := []

    if (result = "Cancel"){
        toggleLayer("Entry")
        Return
    }
    if (result = "TryAgain"){
        toggleLayer("Entry")
        mouseCalibration()
    }

    ; Processing of coordinates goes here

    ; Set appopriate variables

    ; Save to ini file if relevant

    ; toggleLayer("Entry")

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