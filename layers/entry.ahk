#HotIf currentLayer = "Entry"
; ====================================== NINE-BY-NINE BLOCK =====================================
Numpad1::
u::{

}
Numpad2::
i::{

}
Numpad3::
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

Numpad7::
m::{

}
Numpad8::
,::{

}
Numpad9::
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
CapsLock::toggleLayer("Navigation")
Numpad0::
f::toggleLayer("Set-Coordinates")
