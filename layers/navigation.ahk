#HotIf currentLayer = "Navigation"
; ====================================== NINE-BY-NINE BLOCK =====================================
Numpad7::
u::{

}
Numpad8::
i::{

}
Numpad9::
o::{

}

Numpad4::
j::{

}
Numpad5::
k::{

}
Numpad6::
l::{

}

Numpad1::
m::{

}
Numpad2::
,::{

}
Numpad3::
.::{

}
; ====================================== ARROW NAV ======================================
Right::
d:: {
    coordUpdate("x", 1)
}
Left::
a::{
    coordUpdate("x", -1)
}

Up::
w::{
    coordUpdate("y", -1)
}
Down::
s::{
    coordUpdate("y", 1)
}
; ====================================== LAYER TOGGLE ======================================
NumpadAdd::
CapsLock::toggleLayer("Entry")
Numpad0::
f::toggleLayer("Set-Coordinates")