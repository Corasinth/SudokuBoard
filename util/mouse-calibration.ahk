#Requires AutoHotkey v2.0
#SingleInstance Force
CoordMode("Mouse", "Screen")

mouseCalibration(){
    global

    topLeft := ""
    topRight := ""
    bottomLeft := ""
    bottomRight := ""

    tooltipText := "Please click on the top left (🡠) corner of the sudoku grid."
    SetTimer(checkPosition, 20)

    tooltipText := "Please click on the top right (🡢) corner of the sudoku grid."
    tooltipText := "Please click on the bottom left (🡠) corner of the sudoku grid."
    tooltipText := "Please click on the bottom right (🡢) corner of the sudoku grid."

    tickingTooltip("6", -1)
    tickingTooltip("5", -1000)
    tickingTooltip("4", -2000)
    tickingTooltip("3", -3000)
    tickingTooltip("2", -4000)
    tickingTooltip("1", -5000)
    tickingTooltip("0", -6000)
}

tickingTooltip(secondsRemaining, timer){
    global
    SetTimer(() => tooltipText := "Received coordinates " bottomRight "This tooltip will shut off in " secondsRemaining " seconds.", timer)
}

checkPosition(){
    MouseGetPos(&xx, &yy)
    ToolTip(tooltipText " Current Coordinates: " xx ", " yy)
}

closeToolTip(){
    SetTimer(checkPosition, 0)
    ToolTip()
}

mouseCalibration()
Esc::ExitApp