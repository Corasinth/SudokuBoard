readConfigSettings(theKey){
    Return IniRead("./settings.ini", "Configuration Settings", theKey)
}

readMouseSettings(theKey){
    Return IniRead("./settings.ini", "Mouse Mode Settings", theKey)
}

saveCalibrationSettings(topCorners, bottomCorners){
    IniWrite(topCorners, "./settings.ini", "Mouse Mode Settings", "topCorners")
    IniWrite(bottomCorners, "./settings.ini", "Mouse Mode Settings", "bottomCorners")
}