#HotIf currentLayer = "Pencil-Marks"
; ====================================== NINE-BY-NINE BLOCK =====================================
Numpad1::
u::pencilMark("1")
Numpad2::
i::pencilMark("2")
Numpad3::
o::pencilMark("3")

Numpad4::
j::pencilMark("4")
Numpad5::
k::pencilMark("5")
Numpad6::
l::pencilMark("6")

Numpad7::
m::pencilMark("7")
Numpad8::
,::pencilMark("8")
Numpad9::
.::pencilMark("9")

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
CapsLock::toggleLayer("Navigation")
Numpad0::
f::toggleLayer("Set-Coordinates")
~Shift::toggleLayer("Entry")
