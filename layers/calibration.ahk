#HotIf currentLayer = "Calibration"
; ====================================== CALIBRATION ======================================
LButton::{
    MouseGetPos(&XC, &YC)
    sudokuCoordinates.Push([XC, YC])
}
; ====================================== ARROW NAV ======================================
Right::
d::MouseMove(1, 0, 0, "R")

Left::
a::MouseMove(-1, 0, 0, "R")

Up::
w::MouseMove(0, -1, 0, "R")

Down::
s::MouseMove(0, 1, 0, "R")
