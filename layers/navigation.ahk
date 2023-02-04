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
d::coordUpdate("x", 1)

Left::
a::coordUpdate("x", -1)

Up::
w::coordUpdate("y", -1)

Down::
s::coordUpdate("y", 1)
; ====================================== LAYER TOGGLE ======================================
NumpadAdd::
CapsLock::toggleLayer("Entry")
Numpad0::
f::toggleLayer("Set-Coordinates")