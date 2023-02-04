#HotIf currentLayer = "Entry"
; ====================================== NINE-BY-NINE BLOCK =====================================
Numpad1::
u::{
    SendInput("1")
}
Numpad2::
i::{
    SendInput("2")
}
Numpad3::
o::{
    SendInput("3")
}
Numpad4::
j::{
    SendInput("4")
}
Numpad5::
k::{
    SendInput("5")
}
Numpad6::
l::{
    SendInput("6")
}

Numpad7::
m::{
    SendInput("7")
}
Numpad8::
,::{
    SendInput("8")
}
Numpad9::
.::{
    SendInput("9")
}
; ====================================== ARROW NAV ======================================
Right::
d::coordUpdate("x", 1)

Left::
a::coordUpdate("x", -1)

Up::
w::coordUpdate("y", -1)

Down::
s::coordUpdate("y", 1)
; ====================================== LAYER TOGGLE ======================================
NumpadAdd::
CapsLock::toggleLayer("Navigation")
Numpad0::
f::toggleLayer("Set-Coordinates")
