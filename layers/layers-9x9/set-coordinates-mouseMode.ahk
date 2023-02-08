#HotIf (currentLayer = "Set-Coordinates" && mouseMode) 
; ====================================== NINE-BY-NINE BLOCK =====================================
Numpad7::
u::setCoord(1)
Numpad8::
i::setCoord(2)
Numpad9::
o::setCoord(3)

Numpad4::
j::setCoord(4)
Numpad5::
k::setCoord(5)
Numpad6::
l::setCoord(6)

Numpad1::
m::setCoord(7)
Numpad2::
,::setCoord(8)
Numpad3::
.::setCoord(9)

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
e::SendInput("{Backspace}")
; ====================================== LAYER TOGGLE ======================================
NumpadAdd::
CapsLock::toggleLayer("Navigation")
Numpad0::
f::toggleLayer("Entry")