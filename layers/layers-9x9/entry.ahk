#HotIf currentLayer = "Entry"
; ====================================== NINE-BY-NINE BLOCK =====================================
Numpad1::
u::entry("1")
Numpad2::
i::entry("2")
Numpad3::
o::entry("3")

Numpad4::
j::entry("4")
Numpad5::
k::entry("5")
Numpad6::
l::entry("6")

Numpad7::
m::entry("7")
Numpad8::
,::entry("8")
Numpad9::
.::entry("9")
; ====================================== ARROW NAV ======================================
Right::
d::coordUpdate("x", 1)

Left::
a::coordUpdate("x", -1)

Up::
w::coordUpdate("y", -1)

Down::
s::coordUpdate("y", 1)
; ====================================== OTHER CONTROLS ======================================
NumpadDiv::
e::erase()
; ====================================== LAYER TOGGLE ======================================
NumpadAdd::
CapsLock::toggleLayer("Navigation")
Numpad0::
f::toggleLayer("Set-Coordinates")