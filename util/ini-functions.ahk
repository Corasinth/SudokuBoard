readConfigSettings(theKey){
    Return IniRead("./settings.ini", "Configuration Settings", theKey)
}

readMouseSettings(theKey){
    Return IniRead("./settings.ini", "Mouse Mode Settings", theKey)
}

saveCalibrationSettings(startPosition, xOffset, yOffset){
    IniWrite(startPosition, "./settings.ini", "Mouse Mode Settings", "startPosition")
    IniWrite(xOffset, "./settings.ini", "Mouse Mode Settings", "xOffset")
    IniWrite(yOffset, "./settings.ini", "Mouse Mode Settings", "yOffset")
}