#Requires AutoHotkey v2.0
#SingleInstance Force
CoordMode("Mouse", "Screen")
#Include ../layers/calibration.ahk

currentLayer := "on"
toggleLayer(target){
    global
    currentLayer := target
}
sqrSize := 9

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
    mouseCalText := "Welcome to the SudokuBoard mouse calibration!`n`nMouse calibration is important for mouse mode, where the navigation keys move the mouse around, rather than the cursor.`n`nTo calibrate your mouse, you'll need to click the four corners of the sudoku grid in the following order: top left (🡠), top right (🡢), bottom left (🡠), and bottom right (🡢).`n`nIt is important to position the puzzle as desired before continuing; if it is not please cancel calibration and adjust the puzzle appropriately. Otherwise, you will experiance inputs in unexpected places.`n`nIf you experiance troubles with mouse mode, try recalibrating.`n`nFor those who wish to be precise, the arrow and WASD keys will move the cursor one pixel in the appropiate direction during calibration, but extreme accuracy is not required for successful calibration.`n`nClick 'OK' to continue with mouse calibration, or 'Cancel' if you don't wish to proceed."

    result := MsgBox(mouseCalText, "Mouse Calibration", "OKCancel")
    if (result = "Cancel"){
        Return
    }


    ; Displays coordinates in a tooltip for those who like the precision
    SetTimer(checkPosition, 20)

    ; Calibration layer holds the hotkey that saves mouse coordinates to the relevant array on click
    toggleLayer("Calibration")

    while(clickCounter < 4){
        Sleep(50)
    }

    toggleLayer("Entry")
    tickingTooltip(5)

    ; Not strictly necessary, but splitting up the coordinates into seperate variables makes them easier to do calculations on
    topLeft := sudokuCoordinates[1]
    topRight := sudokuCoordinates[2]
    bottomLeft := sudokuCoordinates[3]
    bottomRight := sudokuCoordinates[4]

    ; Text for post cal gui
    postCalText := "Mouse calibration completed!`n`nYou have entered the following coordinates: `n`n(" topLeft[1] ", " topLeft[2] ")  (" topRight[1] ", " topRight[2] ")`n`n(" bottomLeft[1] ", " bottomLeft[2] ")  (" bottomRight[1] ", " bottomRight[2] ")`n`nIf these are acceptable, click continue. If you wish to recalibrate, click Try Again. If you wish to abort calibration, click cancel.`n`nFinally, if you want to save this calibration as the default, check the box below.`n`nWARNING! This will overwrite the current settings. If you wish to save your current settings, you must make the appropriate arrangements to save those before clicking Continue."


    result := MsgBox(postCalText, "Mouse Calibration Complete", "CancelTryAgainContinue")

    ; Reset the sudokuCoordinates regardless of the result of the dialogue box
    sudokuCoordinates := []

    if (result = "Cancel"){
        Return
    }
    if (result = "TryAgain"){
        toggleLayer("Entry")
        mouseCalibration()
    }

    ; Update dialogue boxes to gui

    ; Process coordinates into the start position and offsets
    avgWidth := ((topRight[1] - topLeft[1]) + (bottomRight[1] - bottomLeft[1]))/2
    avgHeight := ((bottomLeft[2] - topLeft[2]) + (bottomRight[2] - topRight[2]))/2

    xOffset := Floor(avgWidth / sqrSize)
    yOffset := Floor(avgHeight / sqrSize)

    ; The start position is to the right side of a cell and halfway down
    startPositionX := Round(topLeft[1] + (.75 * xOffset))
    startPositionY := Round(topLeft[2] + (.5 * yOffset))

    ; MsgBox(startPositionX " " startPositionY " " xOffset " " yOffset " " avgWidth " " avgHeight)

    ; Save to ini file if relevant
    ; if(0){
    ;     saveCalibrationSettings(startPositionX, startPositionY, xOffset, yOffset)
    ; }
}

tickingTooltip(countdownFrom){
    global
    Loop countdownFrom {
        secondsRemaining := countdownFrom - A_Index
        timer := A_Index * -1000
        timerFunc(secondsRemaining, -10)
        if(secondsRemaining = 0){
            ; SetTimer(closeToolTip, timer)
        }
        timerFunc(secondsRemaining, timer){
            SetTimer(() => tooltipText := "Coordinater received! This tooltip will shut off in " secondsRemaining " seconds.", timer)
        }
        timerFunc(secondsRemaining, timer)
    }
}

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

mouseCalibration()