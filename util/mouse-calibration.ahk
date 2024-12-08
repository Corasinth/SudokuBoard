#Requires AutoHotkey v2.0
#SingleInstance Force
CoordMode("Mouse", "Screen")
#Include ../layers/calibration.ahk

; ============================== MAIN CALIBRATION FUNCTION ==============================
mouseCalibration(){
    global
    ; Stores coordinates gained from left click
    sudokuCoordinates := []

    ; Counter that tracks how many times the user has clicked and pushed coordinates to the sudokuCoordinates array
    clickCounter := 0

    ; These are in an array to make it easier to cycle through them
    tooltipTextArr := [
    "top left (🡠)",
    "top right (🡢)",
    "bottom left (🡠)",
    "bottom right (🡢)"
    ]
    ; Text for initial gui
    mouseCalText := "Welcome to the SudokuBoard mouse calibration!`n`nMouse calibration is important for mouse mode, where the navigation keys move the mouse around, rather than the cursor.`n`nTo calibrate your mouse, you'll need to click or press Enter at the four corners of the sudoku grid in the following order: top left (🡠), top right (🡢), bottom left (🡠), and bottom right (🡢).`n`nIt is important to position the puzzle as desired before continuing; if it is not please cancel calibration and adjust the puzzle appropriately. Otherwise, you will experiance inputs in unexpected places.`n`nIf you experience troubles with mouse mode, try recalibrating.`n`nFor those who wish to be precise, the arrow and WASD keys will move the cursor one pixel in the appropriate direction during calibration, but extreme accuracy is not required for successful calibration.`n`nClick 'OK' to continue with mouse calibration, or 'Cancel' if you don't wish to proceed."

    result := MsgBox(mouseCalText, "Mouse Calibration", "OKCancel")
    if (result = "Cancel"){
        Return
    }

    ; Displays coordinates in a tooltip for those who like the precision
    SetTimer(checkPosition, 20)

    ; Calibration layer holds the hotkey that saves mouse coordinates to the relevant array on click
    toggleLayer("Calibration")

    ; Waits for the tooltip array to be cycled through
    while(clickCounter < 4){
        Sleep(50)
    }

    toggleLayer("Entry")
    closeToolTip()
    ; tickingTooltip(2)

    ; Not strictly necessary, but splitting up the coordinates into seperate variables makes them easier to do calculations on
    topLeft := sudokuCoordinates[1]
    topRight := sudokuCoordinates[2]
    bottomLeft := sudokuCoordinates[3]
    bottomRight := sudokuCoordinates[4]

    ; Reset the sudokuCoordinates regardless of the result of the dialogue box
    sudokuCoordinates := []

    ; Text for post cal gui
    postCalText := "Mouse calibration completed!`n`nYou have entered the following coordinates: `n`n(" topLeft[1] ", " topLeft[2] ") (" topRight[1] ", " topRight[2] ")`n`n(" bottomLeft[1] ", " bottomLeft[2] ") (" bottomRight[1] ", " bottomRight[2] ")`n`nIf these are acceptable, click Finish.`n`nClicking Recalibrate will restart the process, but save the previous data.`n`nIf you wish to abort calibration and discard the results, click Abort.`n`nFinally, if you want to save this calibration as the default, check the box below.`n`nWARNING! This will overwrite the current settings if checked, even if you abort calibration.`n`nIf you wish to save your current settings, you must make arrangements to save those first."

    postCal := Gui(,"Mouse Calibration Complete")
    postCal.SetFont("S10")
    postCal.Add("Text",, postCalText)

    finishButton := postCal.Add("Button","Default xp+140 yp+330","Finish")
    finishButton.OnEvent("Click", finishButtonFunc)

    recalibrateButton := postCal.Add("Button", "xp+70","Recalibrate")
    recalibrateButton.OnEvent("Click", recalibrateButtonFunc)

    abortButton:= postCal.Add("Button","xp+100","Abort")
    abortButton.OnEvent("Click", abortButtonFunc)

    saveAsDefault := postCal.Add("Checkbox", "vsaveAsDefault", "Save calibration as default")
    saveAsDefault.Move("180", "375 ")

    ; showGui(){
    postCal.Show("W600")
    ; }
    ; setTimer(showGui, -4000)
}

processCoordinates(){
    global
    ; Process coordinates into the start position and offsets
    avgWidth := ((topRight[1] - topLeft[1]) + (bottomRight[1] - bottomLeft[1]))/2
    avgHeight := ((bottomLeft[2] - topLeft[2]) + (bottomRight[2] - topRight[2]))/2

    xOffset := Floor(avgWidth / sqrSize)
    yOffset := Floor(avgHeight / sqrSize)

    ; The start position is to the right side of a cell and halfway down
    startPositionX := Round(topLeft[1] + (.90 * xOffset))
    startPositionY := Round(topLeft[2] + (.55 * yOffset))
}

; ============================== GUI FUNCTIONS ==============================
finishButtonFunc(*){
    global
    processCoordinates()
    if(saveAsDefault.Value){
        saveCalibrationSettings(startPositionX, startPositionY, xOffset, yOffset)
    }
    postCal.Destroy()
}

recalibrateButtonFunc(*){
    global
    processCoordinates()
    if(saveAsDefault.Value){
        saveCalibrationSettings(startPositionX, startPositionY, xOffset, yOffset)
    }
    postCal.Destroy()
    mouseCalibration()
}

abortButtonFunc(*){
    global
    postCal.Destroy()
}

; ============================== TOOLTIP FUNCTIONS ==============================
; Updates the timer
; tickingTooltip(countdownFrom){
;     global
;     Loop countdownFrom {
;         secondsRemaining := countdownFrom - A_Index
;         timer := A_Index * -1000
;         timerFunc(secondsRemaining, -10)
;         if(secondsRemaining = 0){
;             SetTimer(closeToolTip, timer)
;         }
;         timerFunc(secondsRemaining, timer){
;             SetTimer(() => tooltipText := "Coordinater received! This tooltip will shut off in " secondsRemaining " seconds.", timer)
;         }
;         timerFunc(secondsRemaining, timer)
;     }
; }

checkPosition(){
    global
    if(clickCounter >= 4){
        ; Runs timed tooltip shutdown
        clickCounter := 5
    } else {
        tooltipText := tooltipTextArr[clickCounter + 1]
    }
    MouseGetPos(&xx, &yy)
    ToolTip(tooltipText " Current Coordinates: " xx ", " yy,,,2)
}

closeToolTip(){
    SetTimer(checkPosition, 0)
    Tooltip(,,,2)
}
