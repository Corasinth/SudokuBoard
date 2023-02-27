#HotIf currentLayer = "Entry"
; ====================================== NINE-BY-NINE BLOCK =====================================
1::
Numpad1::
u::entry("1")
2::
Numpad2::
i::entry("2")
3::
Numpad3::
o::entry("3")

4::
Numpad4::
j::entry("4")
5::
Numpad5::
k::entry("5")
6::
Numpad6::
l::entry("6")

7::
Numpad7::
m::entry("7")
8::
Numpad8::
,::entry("8")
9::
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
BackSpace::
NumpadDiv::
e::erase()
; ====================================== LAYER TOGGLE ======================================
NumpadAdd::
CapsLock::toggleLayer("Navigation")
Numpad0::
f::toggleLayer("Set-Coordinates")