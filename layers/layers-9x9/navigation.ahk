#HotIf currentLayer = "Navigation"
; ====================================== NINE-BY-NINE BLOCK =====================================
Numpad7::
u::navigate(1)
Numpad8::
i::navigate(2)
Numpad9::
o::navigate(3)


Numpad4::
j::navigate(4)
Numpad5::
k::navigate(5)
Numpad6::
l::navigate(6)

Numpad1::
m::navigate(7)
Numpad2::
,::navigate(8)
Numpad3::
.::navigate(9)

; ====================================== ARROW NAV ======================================
Right::
d::{
    coordUpdate("x", 1)
    toggleLayer("Entry")
}

Left::
a::{
    coordUpdate("x", -1)
    toggleLayer("Entry")
}

Up::
w::{
    coordUpdate("y", -1)
    toggleLayer("Entry")
}

Down::
s::{
    coordUpdate("y", 1)
    toggleLayer("Entry")
}
; ====================================== OTHER CONTROLS ======================================
NumpadDiv::
e::erase()
; ====================================== LAYER TOGGLE ======================================
NumpadAdd::
CapsLock::toggleLayer("Entry")
Numpad0::
f::toggleLayer("Set-Coordinates")
~Shift::{
    if(webSudokuPencilMarks){
        toggleLayer("Pencil-Marks")
    } 
}