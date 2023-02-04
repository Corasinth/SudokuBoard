#HotIf currentLayer = "Entry"
; ====================================== NINE-BY-NINE BLOCK =====================================
Numpad1::
u::1
Numpad2::
i::2
Numpad3::
o::3
Numpad4::

j::4
Numpad5::
k::5
Numpad6::
l::6

Numpad7::
m::7
Numpad8::
,::8
Numpad9::
.::9
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
